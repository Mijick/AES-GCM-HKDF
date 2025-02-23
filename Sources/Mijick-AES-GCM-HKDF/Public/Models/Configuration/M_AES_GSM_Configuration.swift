//
//  M_AES_GSM_Configuration.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 23.02.2025.
//

import Foundation

public struct M_AES_GSM_Configuration {
    /// The plaintext data to be encrypted. Also represents a cipertext value in a decryption case
    public let message: Data
    
    /// The initialization vector (IV) for AES-GCM.
    /// Can be randomly initialized with method ``Data/randomIV()``
    public let iv: Data
    
    /// Additional authenticated data (AAD) for integrity protection.
    /// Can be empty or randomly initialized with method ``Data/randomAAD()``
    public let add: Data
    
    /// The authentication tag **used only for decryption**.
    public let tag: Data
    
    /// Encryption init
    public init(message: Data, iv: Data, add: Data = .init()) {
        self.message = message
        self.iv = iv
        self.add = add
        self.tag = .init()
    }
    /// Decryption init
    public init(ciperText: Data, tag: Data, iv: Data, add: Data = .init()) {
        self.message = ciperText
        self.iv = iv
        self.add = add
        self.tag = tag
    }
}
