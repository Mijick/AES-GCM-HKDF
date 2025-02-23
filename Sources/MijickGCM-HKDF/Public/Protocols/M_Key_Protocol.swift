//
//  M_Key_Protocol.swift
//  AESGCMHKDF
//
//  Created by Alina Petrovska on 23.02.2025.
//

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
