//
//  SharedSecretBuilder.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 23.02.2025.
//

import Foundation

protocol SharedSecretBuilder {
    func getSharedSecret() throws -> Data
}
