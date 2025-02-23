//
//  HKDF_KeyDerivator.swift
//
//
//  Created by Alina Petrovska on 27.01.2025.
//

import Foundation
import CryptoKit
import CommonCrypto

class HKDF_KeyDerivator {
    private let hashVariant: M_HashVariant
    private let key: Data
    private let salt: Data
    private let info: Data
    private let length: Int
    
    init(key: Data, configuration: M_HKDF_Configuration) {
        self.key = key
        self.salt = configuration.salt
        self.info = configuration.info
        self.length = configuration.length
        self.hashVariant = configuration.hashVariant
    }
}

extension HKDF_KeyDerivator {
    func derive() throws -> Data {
        try validate()
        return derive(hashFunction)
    }
}

private extension HKDF_KeyDerivator {
    func validate() throws {
        guard length <= hashLen else { throw M_AESError.tooMuchIterations }
    }
    func derive<T: HashFunction>(_ type: T.Type) -> Data {
        let prk = getPRK(type)
        let derivedKey = derive(type, .init(data: prk))
        return derivedKey.prefix(length)
    }
}

private extension HKDF_KeyDerivator {
    func getPRK<T: HashFunction>(_ type: T.Type) -> Data {
        HMAC<T>
            .authenticationCode(for: key, using: .init(data: salt))
            .withUnsafeBytes { Data($0) }
    }
    func derive<T: HashFunction>(_ type: T.Type, _ prk: SymmetricKey) -> Data {
        var value = Data()
        var ret = Data()
        ret.reserveCapacity(iterations * hashByteLen)
        
        for i in 1...iterations {
            value.append(contentsOf: info)
            value.append(UInt8(i))
            let bytes = HMAC<T>.authenticationCode(for: value, using: prk).withUnsafeBytes { Data($0) }
            ret.append(contentsOf: bytes)
            value = bytes
        }
        return ret
    }
}

private extension HKDF_KeyDerivator {
    var iterations: Int { Int(ceil(Double(length) / Double(hashByteLen))) }
    var hashLen: Int { hashVariant.hashBitLen }
    var hashByteLen: Int { hashVariant.hashByteLen }
    var hashFunction: any HashFunction.Type { hashVariant.hasFunction }
}
