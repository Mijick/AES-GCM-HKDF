//
//  M_AES_Encryption_Result.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 23.02.2025.
//

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
