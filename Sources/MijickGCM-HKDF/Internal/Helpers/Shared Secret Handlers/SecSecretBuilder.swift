//
//  SecSecretBuilder.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 16.02.2025.
//

import CryptoKit
import Foundation

class SecSecretBuilder: SharedSecretBuilder {
    private let privateKey: SecKey
    private let publicKey: SecKey
    
    init(privateKey: SecKey, publicKey: SecKey) {
        self.privateKey = privateKey
        self.publicKey = publicKey
    }
}

extension SecSecretBuilder {
    func getSharedSecret() throws -> Data {
        let publicData = try getPublicKeyData()
        let privateData = try getPrivateKeyData()
        guard publicData.curve == privateData.curve else { throw M_AESError.curvesMismatch }
        let shared = try getSharedSecret(publicData, privateData)
        return shared.withUnsafeBytes { .init($0) }
    }
}

private extension SecSecretBuilder {
    func getSharedSecret(_ publicData: PublicKeyData, _ privateData: PrivateKeyData) throws -> SharedSecret {
        switch publicData.curve {
            case .P256: try countP256Shared(publicData, privateData)
            case .P384: try countP256Shared(publicData, privateData)
            case .P521: try countP256Shared(publicData, privateData)
        }
    }
    func getPublicKeyData() throws -> PublicKeyData {
        let data = try publicKey.getPublicData()
        return try ECPublicKeyDataReader(data).getComponents()
    }
    func getPrivateKeyData() throws -> PrivateKeyData {
        let data = try privateKey.getPrivateData()
        return try ECPrivateKeyDataReader(data).getComponents()
    }
}

private extension SecSecretBuilder {
    func countP256Shared(_ publicData: PublicKeyData, _ privateData: PrivateKeyData) throws -> SharedSecret {
        try P521.KeyAgreement.PrivateKey(privateData).sharedSecretFromKeyAgreement(with: .init(publicData))
    }
    func countP384Shared(_ publicData: PublicKeyData, _ privateData: PrivateKeyData) throws -> SharedSecret {
        try P384.KeyAgreement.PrivateKey(privateData).sharedSecretFromKeyAgreement(with: try .init(publicData))
    }
    func countP521Shared(_ publicData: PublicKeyData, _ privateData: PrivateKeyData) throws -> SharedSecret {
        try P521.KeyAgreement.PrivateKey(privateData).sharedSecretFromKeyAgreement(with: try .init(publicData))
    }
}
