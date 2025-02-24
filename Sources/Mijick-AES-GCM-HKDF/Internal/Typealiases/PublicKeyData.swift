//
//  PublicKeyData.swift
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
