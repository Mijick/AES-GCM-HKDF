//
//  SecKey+++.swift
//  Mijick-AES-GCM-HKDF
//
//  Created by Alina Petrovska
//    - Mail: alina.petrovska@mijick.com
//    - GitHub: https://github.com/Mijick
//    - GitHub: https://github.com/alina-p-k
//
//  Copyright ©2025 Mijick. All rights reserved.

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
