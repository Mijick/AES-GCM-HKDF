//
//  SharedSecretResolver.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 23.02.2025.
//

import Foundation
import CryptoKit
import Security

class SharedSecretResolver {
    private let publicKey: M_KeyProtocol
    private let privateKey: M_KeyProtocol
    
    init(privateKey: M_KeyProtocol, publicKey: M_KeyProtocol) {
        self.publicKey = publicKey
        self.privateKey = privateKey
    }
}

extension SharedSecretResolver {
    func getSharedSecret() throws -> Data {
        let builder = getBuilder()
        return try builder.getSharedSecret()
    }
}

private extension SharedSecretResolver {
    func getBuilder() -> SharedSecretBuilder {
        if publicKey is SecKey && privateKey is SecKey {
            return SecSecretBuilder(privateKey: publicKey as! SecKey,
                                    publicKey: privateKey as! SecKey)
        } else {
            return CryptoSharedSecretBuilder(publicKey: publicKey, privateKey: privateKey)
        }
    }
}
