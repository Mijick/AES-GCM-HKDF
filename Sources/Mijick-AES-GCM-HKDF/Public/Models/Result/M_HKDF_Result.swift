//
//  M_HKDF_Result.swift
//  Mijick-AES-GCM-HKDF
//
//  Created by Alina Petrovska
//    - Mail: alina.petrovska@mijick.com
//    - GitHub: https://github.com/Mijick
//    - GitHub: https://github.com/alina-p-k
//
//  Copyright ©2025 Mijick. All rights reserved.

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
