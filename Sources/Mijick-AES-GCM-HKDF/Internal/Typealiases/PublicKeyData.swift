//
//  PublicKeyData.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 16.02.2025.
//

import Foundation
import CryptoKit

typealias PublicKeyData = (curve: M_CurveType, x: Data, y: Data)

extension P521.KeyAgreement.PublicKey {
    init(_ data: PublicKeyData) throws {
        self = try .init(rawRepresentation: data.x + data.y)
    }
}
extension P256.KeyAgreement.PublicKey {
    init(_ data: PublicKeyData) throws {
        self = try .init(rawRepresentation: data.x + data.y)
    }
}
extension P384.KeyAgreement.PublicKey {
    init(_ data: PublicKeyData) throws {
        self = try .init(rawRepresentation: data.x + data.y)
    }
}
