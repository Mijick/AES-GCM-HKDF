//
//  M_AES_Encryption_Result.swift
//  Mijick-AES-GCM-HKDF
//
//  Created by Alina Petrovska
//    - Mail: alina.petrovska@mijick.com
//    - GitHub: https://github.com/Mijick
//    - GitHub: https://github.com/alina-p-k
//
//  Copyright ©2025 Mijick. All rights reserved.

import Foundation

/// Represents the result of an **AES-GCM** encryption operation.
public struct M_AES_Encryption_Result {
    /// Initialization vector (IV)
    public let iv: Data
    
    /// Additional authenticated data (AAD)
    public let aad: Data
    
    /// Encrypted message (ciphertext)
    public let cipertext: Data
    
    /// Authentication tag for integrity verification
    public let tag: Data
}
