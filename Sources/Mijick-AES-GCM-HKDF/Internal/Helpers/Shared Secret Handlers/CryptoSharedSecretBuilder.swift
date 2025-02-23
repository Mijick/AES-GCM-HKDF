//
//  CryptoSharedSecretBuilder.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 23.02.2025.
//

import CryptoKit
import Foundation

class CryptoSharedSecretBuilder: SharedSecretBuilder {
    private let publicKey: M_KeyProtocol
    private let privateKey: M_KeyProtocol
    
    init(publicKey: M_KeyProtocol, privateKey: M_KeyProtocol) {
        self.publicKey = publicKey
        self.privateKey = privateKey
    }
}

extension CryptoSharedSecretBuilder {
    func getSharedSecret() throws -> Data {
        switch privateKey {
            case is P256.KeyAgreement.PrivateKey: try countP256Shared()
            case is P384.KeyAgreement.PrivateKey: try countP384Shared()
            case is P521.KeyAgreement.PrivateKey: try countP521Shared()
            case is Curve25519.KeyAgreement.PrivateKey: try countX25519Shared()
            default: throw M_AESError.unsupportedCurve
        }
    }
}

private extension CryptoSharedSecretBuilder {
    func countP256Shared() throws -> Data {
        guard let privateKey = privateKey as? P256.KeyAgreement.PrivateKey,
              let publicKey = publicKey as? P256.KeyAgreement.PublicKey
        else {
            throw M_AESError.curvesMismatch
        }
        return try privateKey
            .sharedSecretFromKeyAgreement(with: publicKey)
            .withUnsafeBytes { Data($0) }
    }
    func countP384Shared() throws -> Data {
        guard let privateKey = privateKey as? P384.KeyAgreement.PrivateKey,
              let publicKey = publicKey as? P384.KeyAgreement.PublicKey
        else {
            throw M_AESError.curvesMismatch
        }
        return try privateKey
            .sharedSecretFromKeyAgreement(with: publicKey)
            .withUnsafeBytes { Data($0) }
    }
    func countP521Shared() throws -> Data {
        guard let privateKey = privateKey as? P521.KeyAgreement.PrivateKey,
              let publicKey = publicKey as? P521.KeyAgreement.PublicKey
        else {
            throw M_AESError.curvesMismatch
        }
        return try privateKey
            .sharedSecretFromKeyAgreement(with: publicKey)
            .withUnsafeBytes { Data($0) }
    }
    func countX25519Shared() throws -> Data {
        guard let privateKey = privateKey as? Curve25519.KeyAgreement.PrivateKey,
              let publicKey = publicKey as? Curve25519.KeyAgreement.PublicKey
        else {
            throw M_AESError.curvesMismatch
        }
        return try privateKey
            .sharedSecretFromKeyAgreement(with: publicKey)
            .withUnsafeBytes { Data($0) }
    }
}
