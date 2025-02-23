//
//  AES_GCM_Decrypter.swift
//
//
//  Created by Alina Petrovska on 28.01.2025.
//

import Foundation
import CryptoKit

class AES_GCM_Decrypter {
    private let secret: Data
    private let tag: Data
    private let iv: Data
    private let ciphertext: Data
    
    init(secret: Data, configuration: M_AES_GSM_Configuration) {
        self.secret = secret
        self.tag = configuration.tag
        self.iv = configuration.iv
        self.ciphertext = configuration.message
    }
}

extension AES_GCM_Decrypter {
    func decrypt() throws -> Data {
        let nonce = try AES.GCM.Nonce(data: iv)
        let box = try AES.GCM.SealedBox(nonce: nonce, ciphertext: ciphertext, tag: tag)
        let key = SymmetricKey(data: secret)
        return try AES.GCM.open(box, using: key)
    }
}
