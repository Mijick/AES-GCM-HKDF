//
//  ECPrivateKeyDataReader.swift
//  Mijick-AES-GCM-HKDF
//
//  Created by Alina Petrovska
//    - Mail: alina.petrovska@mijick.com
//    - GitHub: https://github.com/Mijick
//    - GitHub: https://github.com/alina-p-k
//
//  Copyright ©2025 Mijick. All rights reserved.

import Foundation
import CryptoKit

class ECPrivateKeyDataReader {
    private let data: Data
    
    init(_ data: Data) { self.data = data }
}

extension ECPrivateKeyDataReader {
    func getComponents() throws -> PrivateKeyData {
        var privateKeyBytes = [UInt8](data)

        guard privateKeyBytes.removeFirst() == 0x04
        else { throw M_AESError.compressedCurvePointsUnsupported }

        let pointSize = privateKeyBytes.count / 3
        guard let curve = M_CurveType.fromCoordinateOctetLength(pointSize)
        else { throw M_AESError.invalidCurvePointOctetLength }

        let xBytes = privateKeyBytes[0 ..< pointSize]
        let yBytes = privateKeyBytes[pointSize ..< pointSize * 2]
        let dBytes = privateKeyBytes[pointSize * 2 ..< pointSize * 3]
        let xData = Data(xBytes)
        let yData = Data(yBytes)
        let dData = Data(dBytes)
        return (curve, xData, yData, dData)
    }
}
