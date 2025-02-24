//
//  AESEncryptionTests.swift
//  Mijick-AES-GCM-HKDF
//
//  Created by Alina Petrovska
//    - Mail: alina.petrovska@mijick.com
//    - GitHub: https://github.com/Mijick
//    - GitHub: https://github.com/alina-p-k
//
//  Copyright ©2025 Mijick. All rights reserved.

import Testing
import CryptoKit
import Foundation
@testable import Mijick_AES_GCM_HKDF

struct AESEncryptionTests {
    @Test("AES-GCM Encryption Success") func encryptSuccess() throws {
        let secretKey = Data.randomSalt(.sha256)
        let aesConfig = M_AES_GSM_Configuration(
            message: Data("Hello, Secure World!".utf8),
            iv: Data.randomIV(),
            aad: Data.randomAAD()
        )
        let encryptionResult = try M_AES_GCM_HKDF.encrypt(secret: secretKey, configuration: aesConfig)

        #expect(!encryptionResult.cipertext.isEmpty)
        #expect(!encryptionResult.tag.isEmpty)
    }
    @Test("AES-GCM Encryption with Invalid Key") func encryptInvalidKey() throws {
        let invalidKey = Data()
        let aesConfig = M_AES_GSM_Configuration(
            message: Data("Test Message".utf8),
            iv: Data.randomIV(),
            aad: Data.randomAAD()
        )

        #expect(throws: M_AESError.incorrectSecretSize) {
            try M_AES_GCM_HKDF.encrypt(secret: invalidKey, configuration: aesConfig)
        }
    }
}



private extension AESEncryptionTests {
    var message: Data { Data("Encrypted Message".utf8) }
}

