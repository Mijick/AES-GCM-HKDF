//
//  M_AESError.swift
//  Mijick-AES-GCM-HKDF
//
//  Created by Alina Petrovska
//    - Mail: alina.petrovska@mijick.com
//    - GitHub: https://github.com/Mijick
//    - GitHub: https://github.com/alina-p-k
//
//  Copyright ©2025 Mijick. All rights reserved.

/// Representing errors that may occur during key derivation, encryption, and decryption processes in the AES-GCM and HKDF cryptographic system.
public enum M_AESError: Error {
    /// The key derivation function (HKDF) exceeds a safe iteration limit to generate a derived key.
    /// - Important: Reduce the number of iterations in HKDF settings ``M_HKDF_Configuration``.
    case tooMuchIterations
    
    /// The requested key length exceeds the maximum allowable size for the selected hash function in HKDF.
    /// - Important: Reduce the number of iterations in HKDF settings ``M_HKDF_Configuration``. Ensure it does not exceed the hash function's output size multiplied by 255 (as per RFC 5869)
    case tooBigLengthOfKey
    
    /// HKDF fails to derive a cryptographic key due to incorrect parameters or internal errors.
    ///  - Important: Verify that the shared key, salt, and info are correctly provided in ``M_HKDF_Configuration``
    case unableToDeriveKey
    
    /// A non-private key is mistakenly used where a private key is required.
    /// - Important: Ensure you are passing a private key ``M_KeyProtocol`` instead of a public key.
    case notAPrivateKey
    
    /// A non-public key is mistakenly used where a public key is required.
    /// - Important: Ensure you are passing a public key ``M_KeyProtocol`` instead of a private key.
    case notAPublicKey
    
    /// The cryptographic system does not support compressed elliptic curve points.
    /// - Important: Use uncompressed elliptic curve points for key exchange.
    case compressedCurvePointsUnsupported
    
    
    /// The curve point representation has an incorrect length (octet encoding format).
    /// - Important: Ensure that the key uses the correct octet length according to the curve specifications.
    case invalidCurvePointOctetLength
    
    /// The private and public keys belong to different elliptic curves in ECDH key agreement.
    /// - Important: Ensure that both keys are from the same curve family (e.g., both P256 or both Curve25519).
    case curvesMismatch
    
    /// The selected elliptic curve is not supported by the cryptographic system.
    ///
    /// - Important: Use a supported curve.
    ///
    /// - Note:
    /// - NIST curves: P256, P384, P521.
    /// - Modern high-security curves: Curve25519.
    case unsupportedCurve
    
    /// A hexadecimal string is improperly formatted or contains invalid characters.
    /// - Important: Ensure the input is a valid hexadecimal string.
    case incorrectHexFormat
}

