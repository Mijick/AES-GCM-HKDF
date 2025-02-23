//
//  Optional+++.swift
//  Mijick-AES-GCM-HKDF
//
//  Created by Alina Petrovska
//    - Mail: alina.petrovska@mijick.com
//    - GitHub: https://github.com/Mijick
//    - GitHub: https://github.com/alina-p-k
//
//  Copyright ©2025 Mijick. All rights reserved.

import Foundation

infix operator ???
extension Optional {
    static func ???(lhs: Optional, error: Error) throws -> Wrapped {
        if let wrapped = lhs { return wrapped }
        else { throw error }
    }
}
