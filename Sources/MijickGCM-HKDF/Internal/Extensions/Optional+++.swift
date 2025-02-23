//
//  Optional+++.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 20.02.2025.
//

import Foundation

infix operator ???
extension Optional {
    static func ???(lhs: Optional, error: Error) throws -> Wrapped {
        if let wrapped = lhs { return wrapped }
        else { throw error }
    }
}
