//
//  M_Key_Protocol.swift
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

/// Represents cryptographic keys used for key agreement operations (such as ECDH - Elliptic Curve Diffie-Hellman).
///  - Note:
///  - This protocol serves as a common interface for various key types, allowing them to be used interchangeably in cryptographic operations like shared secret computation and secure key derivation.
public protocol M_KeyProtocol { }

extension SecKey: M_KeyProtocol { }

extension P256.KeyAgreement.PrivateKey: M_KeyProtocol { }
extension P256.KeyAgreement.PublicKey: M_KeyProtocol { }

extension P384.KeyAgreement.PrivateKey: M_KeyProtocol { }
extension P384.KeyAgreement.PublicKey: M_KeyProtocol { }

extension P521.KeyAgreement.PrivateKey: M_KeyProtocol { }
extension P521.KeyAgreement.PublicKey: M_KeyProtocol { }

extension Curve25519.KeyAgreement.PrivateKey: M_KeyProtocol { }
extension Curve25519.KeyAgreement.PublicKey: M_KeyProtocol { }
