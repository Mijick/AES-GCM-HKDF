//
//  Data+++.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 16.02.2025.
//

import Foundation

extension Data {
    init?(hex: String) {
        guard hex.count.isMultiple(of: 2) else { return nil }
        let chars = hex.map { $0 }
        let bytes = stride(from: 0, to: chars.count, by: 2)
            .map { String(chars[$0]) + String(chars[$0 + 1]) }
            .compactMap { UInt8($0, radix: 16) }
        
        guard hex.count / bytes.count == 2 else { return nil }
        self.init(bytes)
    }
}

extension Data {
    static func generateRandom(of size: Int) -> Data {
        var buffer = Data(count: size)
        let result = buffer.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, size, $0.baseAddress!)
        }
        return buffer
    }
}

extension Data {
    var hexString: String { map { String(format: "%02x", $0) }.joined() }
}
