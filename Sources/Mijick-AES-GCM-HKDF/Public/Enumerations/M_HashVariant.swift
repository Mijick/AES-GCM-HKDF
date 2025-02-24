//
//  M_HashVariant.swift
//  Mijick-AES-GCM-HKDF
//
//  Created by Alina Petrovska
//    - Mail: alina.petrovska@mijick.com
//    - GitHub: https://github.com/Mijick
//    - GitHub: https://github.com/alina-p-k
//
//  Copyright ©2025 Mijick. All rights reserved.

import CryptoKit
import CommonCrypto

public enum M_HashVariant {
    /// Deprecated for security reasons (use stronger hashes instead).
    case sha1
    
    /// Recommended for general-purpose cryptographic applications.
    case sha256
    
    /// Provides increased security with a larger digest.
    case sha384
    
    /// Strongest option but may be slower.
    case sha512
}

extension M_HashVariant {
    var hasFunction: any HashFunction.Type {
        switch self {
            case .sha1: Insecure.SHA1.self
            case .sha256: SHA256.self
            case .sha384: SHA384.self
            case .sha512: SHA512.self
        }
    }
    var hashByteLen: Int {
        switch self {
            case .sha1: Insecure.SHA1.Digest.byteCount
            case .sha256: SHA256.Digest.byteCount
            case .sha384: SHA384.Digest.byteCount
            case .sha512: SHA512.Digest.byteCount
        }
    }
    var hashBitLen: Int {
        hashByteLen * 8
    }
}
