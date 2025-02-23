//
//  M_HKDF_Configuration.swift
//  Mijick-AES-GCM-HKDF
//
//  Created by Alina Petrovska
//    - Mail: alina.petrovska@mijick.com
//    - GitHub: https://github.com/Mijick
//    - GitHub: https://github.com/alina-p-k
//
//  Copyright ©2025 Mijick. All rights reserved.

import Foundation

/// Defines the configuration parameters required for the HKDF function.
public struct M_HKDF_Configuration {
    /// The hash function to use
    public let hashVariant: M_HashVariant
    
    /// A random salt value to strengthen security.
    /// Can be empty or formed randomly by using the method  ``Data/randomSalt(_:)``
    public let salt: Data
    
    /// Optional context-specific information for key derivation.
    /// Can be empty or formed randomly by using the method  ``Data/randomInfo(_:)``
    public let info: Data
    
    /// The desired length (in bytes) of the derived key.
    public let length: Int
    
    public init(hashVariant: M_HashVariant, salt: Data = .init(), info: Data = .init(), length: Int) {
        self.hashVariant = hashVariant
        self.salt = salt
        self.info = info
        self.length = length
    }
    public init(hashVariant: M_HashVariant, hexSalt: String, hexInfo: String, length: Int) throws {
        self.init(hashVariant: hashVariant,
                  salt: try Data(hexParameter: hexSalt),
                  info: try Data(hexParameter: hexInfo),
                  length: length)
    }
}

// MARK: Helpers
fileprivate extension Data {
    init(hexParameter: String) throws {
        if hexParameter.isEmpty { self = Data() }
        else { self = try Data(hex: hexParameter) ??? M_AESError.incorrectHexFormat }
    }
}
