//
//  ECPublicKeyDataReader.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 23.02.2025.
//

import Foundation
import CryptoKit

class ECPublicKeyDataReader {
    private let data: Data
    
    init(_ data: Data) { self.data = data }
}

extension ECPublicKeyDataReader {
    func getComponents() throws -> PublicKeyData {
        var publicKeyBytes = [UInt8](data)
        guard publicKeyBytes.removeFirst() == 0x04 else { throw M_AESError.compressedCurvePointsUnsupported }
        
        let pointSize = publicKeyBytes.count / 2
        guard let curve = M_CurveType.fromCoordinateOctetLength(pointSize)
        else { throw M_AESError.invalidCurvePointOctetLength }

        let xBytes = publicKeyBytes[0..<pointSize]
        let yBytes = publicKeyBytes[pointSize..<pointSize*2]
        let xData = Data(xBytes)
        let yData = Data(yBytes)
        return (curve, xData, yData)
    }
}
