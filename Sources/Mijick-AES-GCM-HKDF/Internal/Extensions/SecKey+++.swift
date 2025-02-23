//
//  SecKey+++.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 16.02.2025.
//

import Security
import CommonCrypto
import Foundation

extension SecKey {
    func getPrivateData() throws -> Data {
        guard let attributes = SecKeyCopyAttributes(self) as? [CFString: AnyObject],
              let keyClass = attributes[kSecAttrKeyClass],
              keyClass as! CFString == kSecAttrKeyClassPrivate
        else { throw M_AESError.notAPrivateKey }
        
        var error: Unmanaged<CFError>?
        guard let keyData = SecKeyCopyExternalRepresentation(self, &error)
        else { throw error!.takeRetainedValue() as Error }
        
        return keyData as Data
    }
    func getPublicData() throws -> Data {
        guard let attributes = SecKeyCopyAttributes(self) as? [CFString: AnyObject],
              let keyClass = attributes[kSecAttrKeyClass],
              keyClass as! CFString == kSecAttrKeyClassPublic
        else { throw M_AESError.notAPublicKey }
        
        var error: Unmanaged<CFError>?
        guard let keyData = SecKeyCopyExternalRepresentation(self, &error)
        else { throw error!.takeRetainedValue() as Error }
        
        return keyData as Data
    }
}
