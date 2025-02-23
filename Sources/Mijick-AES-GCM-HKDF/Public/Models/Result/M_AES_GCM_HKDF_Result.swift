//
//  M_AES_GCM_HKDF_Result.swift
//  Mijick-AES-GCM-HKDF
//
//  Created by Alina Petrovska
//    - Mail: alina.petrovska@mijick.com
//    - GitHub: https://github.com/Mijick
//    - GitHub: https://github.com/alina-p-k
//
//  Copyright ©2025 Mijick. All rights reserved.
/// Represents the final result of the entire encryption process, which includes:
public struct M_AES_GCM_HKDF_Result {
    /// The result of the HKDF key derivation process, which provides the encryption key used for **AES-GCM**
    public let derivationResult: M_HKDF_Result
    
    /// Encryption Operation result
    public let encryptionResult: M_AES_Encryption_Result
}
