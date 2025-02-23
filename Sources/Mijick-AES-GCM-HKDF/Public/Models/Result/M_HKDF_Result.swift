//
//  M_HKDF_Result.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 20.02.2025.
//

import Foundation

/// Object encapsulates the result of the HKDF key derivation process.
public struct M_HKDF_Result {
    /// The salt used in derivation.
    public let salt: Data
    
    /// The context used in the derivation.
    /// Can be empty.
    public let info: Data
    
    /// The output key derived from the shared secret.
    public let derivedKey: Data
}
