//
//  AESDecryptionTests.swift
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


struct AESDecryptionTests {
    @Test("AES-GCM Decryption Success") func successfulDecryption() throws {
        let secretKey = Data.randomSalt(.sha256)
        let encryptionResult = try getEncryptedData(secretKey)
        let decryptionConfig = M_AES_GSM_Configuration(
            ciperText: encryptionResult.cipertext,
            tag: encryptionResult.tag,
            iv: encryptionResult.iv,
            add: encryptionResult.aad
        )
        
        let decryptedMessage = try M_AES_GCM_HKDF.decrypt(secret: secretKey, configuration: decryptionConfig)
        print(decryptedMessage.hexString)
        #expect(decryptedMessage == message)
    }
    @Test("AES-GCM Decryption with Wrong Key") func decryptionFailureWithWrongKey() throws {
        let secretKey = Data.randomSalt(.sha256)
        let wrongKey = Data.randomSalt(.sha256)
        let encryptionResult = try getEncryptedData(secretKey)
        
        let decryptionConfig = M_AES_GSM_Configuration(
            ciperText: encryptionResult.cipertext,
            tag: encryptionResult.tag,
            iv: encryptionResult.iv,
            add: encryptionResult.aad
        )
        let result = try? M_AES_GCM_HKDF.decrypt(secret: wrongKey, configuration: decryptionConfig)
        #expect(result == nil)
    }
}

private extension AESDecryptionTests {
    func getEncryptedData(_ key: Data) throws -> M_AES_Encryption_Result {
        let configuration = M_AES_GSM_Configuration(
            message: message,
            iv: Data.randomIV(),
            aad: Data.randomAAD()
        )
        return try M_AES_GCM_HKDF.encrypt(secret: key, configuration: configuration)
    }
}

private extension AESDecryptionTests {
    var message: Data { Data("Encrypted Message".utf8) }
}
