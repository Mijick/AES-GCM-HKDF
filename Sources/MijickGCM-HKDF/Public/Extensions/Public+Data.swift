//
//  Public+Data.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 20.02.2025.
//

import Foundation

public extension Data {
    /// Generates a random cryptographic salt of a size based on the provided hash function.
    static func randomSalt(_ hash: M_HashVariant) -> Data { generateRandom(of: hash.hashByteLen) }
    
    /// Generates a random cryptographic info of a size based on the provided hash function.
    static func randomInfo(_ hash: M_HashVariant) -> Data { generateRandom(of: hash.infoByteLength) }
    
    /// Generates a random Initialization Vector (IV) for use in AES-GCM encryption.
    static func randomIV() -> Data { generateRandom(of: 12) }
    
    /// Generates random Additional Authenticated Data (AAD) for AES-GCM encryption.
    static func randomAAD() -> Data { generateRandom(of: 16) }
}

// MARK: Helpers
fileprivate extension M_HashVariant {
    var infoByteLength: Int {
        switch self {
            case .sha1, .sha256: 64
            case .sha384, .sha512: 128
        }
    }
}
