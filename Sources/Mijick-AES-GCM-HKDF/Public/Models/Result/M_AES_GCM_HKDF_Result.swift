//
//  M_AES_GCM_HKDF_Result.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 23.02.2025.
//

/// Represents the final result of the entire encryption process, which includes:
public struct M_AES_GCM_HKDF_Result {
    /// The result of the HKDF key derivation process, which provides the encryption key used for **AES-GCM**
    public let derivationResult: M_HKDF_Result
    
    /// Encryption Operation result
    public let encryptionResult: M_AES_Encryption_Result
}
