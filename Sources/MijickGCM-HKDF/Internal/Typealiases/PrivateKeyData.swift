//
//  PrivateKeyData.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 16.02.2025.
//

import Foundation
import CryptoKit

typealias PrivateKeyData = (curve: M_CurveType, x: Data, y: Data, d: Data)

extension P256.KeyAgreement.PrivateKey {
    init(_ data: PrivateKeyData) throws {
        self = try .init(rawRepresentation: data.x + data.y + data.d)
    }
}
extension P384.KeyAgreement.PrivateKey {
    init(_ data: PrivateKeyData) throws {
        self = try .init(rawRepresentation: data.x + data.y + data.d)
    }
}
extension P521.KeyAgreement.PrivateKey {
    init(_ data: PrivateKeyData) throws {
        self = try .init(rawRepresentation: data.x + data.y + data.d)
    }
}
