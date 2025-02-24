//
//  PrivateKeyData.swift
//  Mijick-AES-GCM-HKDF
//
//  Created by Alina Petrovska
//    - Mail: alina.petrovska@mijick.com
//    - GitHub: https://github.com/Mijick
//    - GitHub: https://github.com/alina-p-k
//
//  Copyright ©2025 Mijick. All rights reserved.

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
