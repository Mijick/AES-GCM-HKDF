//
//  M_CurveType.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 16.02.2025.
//

import Foundation

enum M_CurveType: String {
    case P256 = "P-256"
    case P384 = "P-384"
    case P521 = "P-521"
}

extension M_CurveType {
    static func fromKeyBitLength(_ length: Int) -> M_CurveType? {
        switch length {
            case M_CurveType.P256.keyBitLength: .P256
            case M_CurveType.P384.keyBitLength: .P384
            case M_CurveType.P521.keyBitLength: .P521
            default: nil
        }
    }
    static func fromCoordinateOctetLength(_ length: Int) -> M_CurveType? {
        switch length {
            case M_CurveType.P256.coordinateOctetLength: .P256
            case M_CurveType.P384.coordinateOctetLength: .P384
            case M_CurveType.P521.coordinateOctetLength: .P521
            default: nil
        }
    }
}

private extension M_CurveType {
    var keyBitLength: Int {
        switch self {
            case .P256: 256
            case .P384: 384
            case .P521: 521
        }
    }
    var coordinateOctetLength: Int {
        switch self {
            case .P256: 32
            case .P384: 48
            case .P521: 66
        }
    }
}
