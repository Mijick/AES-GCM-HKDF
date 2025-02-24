//
//  KeyAgreementTests.swift
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
@testable import Mijick_AES_GCM_HKDF


struct KeyAgreementTests {
    @Test("Shared Secret Generation") func sharedSecretGeneration() throws {
        let privateKey = P256.KeyAgreement.PrivateKey()
        let publicKey = privateKey.publicKey

        let sharedSecret = try M_AES_GCM_HKDF.getSharedSecret(privateKey: privateKey, publicKey: publicKey)
        #expect(!sharedSecret.isEmpty)
    }
    @Test("Mismatched Curve Error") func mismatchedCurveError() throws {
        let privateKey = P256.KeyAgreement.PrivateKey()
        let anotherPublicKey = P384.KeyAgreement.PrivateKey().publicKey

        #expect(throws: M_AESError.curvesMismatch) {
            try M_AES_GCM_HKDF.getSharedSecret(privateKey: privateKey, publicKey: anotherPublicKey)
        }
    }
}
