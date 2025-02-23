//
//  AES_GCM_Encryptor.swift
//
//  Created by Alina Petrovska
//    - Mail: alina.petrovska@mijick.com
//    - GitHub: https://github.com/Mijick
//    - GitHub: https://github.com/alina-p-k
//
//  Copyright ©2025 Mijick. All rights reserved.

import Foundation
import CryptoKit

class AES_GCM_Encryptor {
    private let secret: Data
    private let iv: Data
    private let message: Data
    private let add: Data
    
    init(secret: Data, config: M_AES_GSM_Configuration) {
        self.secret = secret
        self.iv = config.iv
        self.message = config.message
        self.add = config.add
    }
}

extension AES_GCM_Encryptor {
    func encrypt() throws -> AES.GCM.SealedBox {
        let key = SymmetricKey(data: secret)
        let nonce = try AES.GCM.Nonce(data: iv)
        let sealedBox = try AES.GCM.seal(message, using: key, nonce: nonce, authenticating: add)
        return sealedBox
    }
}
