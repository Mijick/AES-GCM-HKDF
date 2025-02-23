//
//  M_GCM_HKDF.swift
//
//
//  Created by Alina Petrovska on 27.01.2025.
//

import Foundation
import CryptoKit

public class M_GCM_HKDF { }

// MARK: Shared Secret
public extension M_GCM_HKDF {
    /**
     Computes a shared secret from a key pair using elliptic curve cryptography.
     - Parameters:
     - privateKey: A private key conforming to ``M_KeyProtocol``. Must be suitable for key agreement operations.
     - publicKey:  A public key conforming to ``M_KeyProtocol``. Must be on the same curve as privateKey.
     
     - Returns: A ``Data`` object representing the derived shared secret.
     
     - Note:
     - Supports keys of types **SecKey**, **P256**, **P384**, **P521**, and **Curve25519**.
     
     - WARNING: Both keys must be from the same elliptic curve type; otherwise, the function will throw an error.
     */
    static func getSharedSecret(privateKey: M_KeyProtocol, publicKey: M_KeyProtocol) throws -> Data {
        try SharedSecretResolver(privateKey: privateKey, publicKey: publicKey).getSharedSecret()
    }
}

// MARK: Derivation
public extension M_GCM_HKDF {
    /**
     Implements the HMAC-based Extract-and-Expand Key Derivation Function (HKDF) as described in [RFC 5869](https://datatracker.ietf.org/doc/html/rfc5869).
        
     - Parameters:
       - privateKey: A private key conforming to ``M_KeyProtocol``. Must be suitable for key agreement operations.
       - publicKey:  A public key conforming to ``M_KeyProtocol``. Must be on the same curve as privateKey.
       - configuration: An instance of ``M_HKDF_Configuration``, which specifies parameters for the HKDF derivation.
    
     - Note:
     - This method performs a two-step process:
       - Computes a shared secret using elliptic curve key agreement (ECDH).
       - Derives a cryptographic key from the shared secret using the HMAC-based Extract-and-Expand Key Derivation Function (HKDF), as specified in [RFC 5869](https://datatracker.ietf.org/doc/html/rfc5869).
     
     - Returns: Returns ``M_HKDF_Result``
     */
    static func deriveKey(privateKey: M_KeyProtocol, publicKey: M_KeyProtocol, configuration: M_HKDF_Configuration) throws -> M_HKDF_Result {
        let sharedSecret = try getSharedSecret(privateKey: privateKey, publicKey: publicKey)
        return try deriveKey(key: sharedSecret, configuration: configuration)
    }
    /**
     Implements the HMAC-based Extract-and-Expand Key Derivation Function (HKDF) as described in [RFC 5869](https://datatracker.ietf.org/doc/html/rfc5869).
     This method is useful for securely deriving multiple keys from a shared secret, ensuring key separation and resistance against cryptographic attacks.
     - Parameters:
        - key: A ``Data`` object representing the shared secret, typically obtained from a key agreement operation.
        - configuration: An instance of ``M_HKDF_Configuration``, which specifies parameters for the HKDF derivation.
     
     - Returns: Returns ``M_HKDF_Result``
     */
    static func deriveKey(key: Data, configuration: M_HKDF_Configuration) throws -> M_HKDF_Result {
        let derivedKey = try HKDF_KeyDerivator(key: key, configuration: configuration).derive()
        return .init(salt: configuration.salt, info: configuration.info, derivedKey: derivedKey)
    }
}

// MARK: Encryption
public extension M_GCM_HKDF {
    /**
     Performs a secure encryption process using **AES-GCM** with an **HKDF**-derived key.
     
     - Parameters:
       - privateKey: A private key conforming to ``M_KeyProtocol``. Must be suitable for key agreement operations.
       - publicKey: A public key conforming to ``M_KeyProtocol``. Must be on the same curve as privateKey.
       - derivationConfig: An instance of ``M_HKDF_Configuration``, which specifies parameters for the HKDF derivation.
       - encryptionConfig: An instance of ``M_AES_GSM_Configuration``, which specifies parameters for the AES-GCM encryption.
     
     - Note:
     - This method follows three main steps:
       - Computes a shared secret using elliptic curve key agreement (ECDH).
       - Derives a cryptographic key from the shared secret using the HMAC-based Extract-and-Expand Key Derivation Function (HKDF), as specified in [RFC 5869](https://datatracker.ietf.org/doc/html/rfc5869).
       - Encrypt the message using AES-GCM with the derived key.
     
     - Returns: Returns ``M_AES_GCM_HKDF_Result``
     */
    static func encrypt(privateKey: M_KeyProtocol, publicKey: M_KeyProtocol, derivationConfig: M_HKDF_Configuration, encryptionConfig: M_AES_GSM_Configuration) throws -> M_AES_GCM_HKDF_Result {
        let sharedSecret = try getSharedSecret(privateKey: privateKey, publicKey: publicKey)
        return try encrypt(key: sharedSecret, derivationConfig: derivationConfig, encryptionConfig: encryptionConfig)
    }
    
    /**
     Performs a secure encryption process using **AES-GCM** with an **HKDF**-derived key.
     Useful when the shared secret is already computed, eliminating the need for key agreement (ECDH).
     
     - Parameters:
       - key: A ``Data`` object representing the shared secret, typically obtained from a key agreement operation.
       - derivationConfig: An instance of ``M_HKDF_Configuration``, which specifies parameters for the HKDF derivation.
       - encryptionConfig: An instance of ``M_AES_GSM_Configuration``, which specifies parameters for the AES-GCM encryption.
     
     - Note:
     - This function directly accepts a shared secret and follows these steps:
       - Derives a cryptographic key from the shared secret using the HMAC-based Extract-and-Expand Key Derivation Function (HKDF), as specified in [RFC 5869](https://datatracker.ietf.org/doc/html/rfc5869).
       - Encrypt the message using AES-GCM with the derived key.
     
     - Returns: Returns ``M_AES_GCM_HKDF_Result``
     */
    static func encrypt(key: Data, derivationConfig: M_HKDF_Configuration, encryptionConfig: M_AES_GSM_Configuration) throws -> M_AES_GCM_HKDF_Result {
        let derivationResult = try deriveKey(key: key, configuration: derivationConfig)
        let encryptionResult = try encrypt(secret: derivationResult.derivedKey, configuration: encryptionConfig)
        return .init(derivationResult: derivationResult, encryptionResult: encryptionResult)
    }
    
    /**
     Performs **AES-GCM** encryption using a pre-derived symmetric key.
     
     - Parameters:
       - secret: A pre-derived symmetric key ``Data`` used for AES-GCM encryption.
       - configuration: An instance of ``M_AES_GSM_Configuration``, which specifies parameters for the AES-GCM encryption.
     
     - Note:
     - This method is designed for cases where the encryption key is already derived, either via HKDF or another key exchange process. It provides confidentiality and integrity protection for the encrypted message.
     
     - Returns: Returns ``M_AES_Encryption_Result``
     */
    static func encrypt(secret: Data, configuration: M_AES_GSM_Configuration) throws -> M_AES_Encryption_Result {
        let result = try AES_GCM_Encryptor(secret: secret, config: configuration).encrypt()
        return .init(iv: configuration.iv, aad: configuration.add, cipertext: result.ciphertext, tag: result.tag)
    }
}

// MARK: Decryption
public extension M_GCM_HKDF {
    /**
     Performs a secure decryption process using **AES-GCM** with an **HKDF**-derived key.
     This method ensures end-to-end secure decryption by combining key agreement, key derivation, and authenticated decryption.
     
     - Parameters:
       - privateKey: A private key conforming to ``M_KeyProtocol``. Must be suitable for key agreement operations.
       - publicKey: A public key conforming to ``M_KeyProtocol``. Must be on the same curve as privateKey.
       - derivationConfig: An instance of ``M_HKDF_Configuration``, which specifies parameters for the HKDF derivation.
       - decryptionConfig: An instance of ``M_AES_GSM_Configuration``, which specifies parameters for the AES-GCM decryption.
     
     - Note:
     - This method follows three main steps:
       - Computes a shared secret using elliptic curve key agreement (ECDH).
       - Derives a cryptographic key from the shared secret using the HMAC-based Extract-and-Expand Key Derivation Function (HKDF), as specified in [RFC 5869](https://datatracker.ietf.org/doc/html/rfc5869).
       - Decrypts the AES-GCM encrypted message and returns the original plaintext.
     
     - Returns: Returns a ``Data`` object containing the decrypted message.
     */
    static func decrypt(privateKey: M_KeyProtocol, publicKey: M_KeyProtocol, derivationConfig: M_HKDF_Configuration, decryptionConfig: M_AES_GSM_Configuration) throws -> Data {
        let sharedSecret = try getSharedSecret(privateKey: privateKey, publicKey: publicKey)
        return try decrypt(key: sharedSecret, derivationConfig: derivationConfig, decryptionConfig: decryptionConfig)
    }
    
    /**
     Performs a secure decryption process using **AES-GCM** with an **HKDF**-derived symmetric key.
     This method is designed for cases where the shared secret is already computed, eliminating the need for key agreement (ECDH).
     
     - Parameters:
       - key: A ``Data`` object representing the shared secret, typically obtained from a key agreement operation.
       - derivationConfig: An instance of ``M_HKDF_Configuration``, which specifies parameters for the HKDF derivation.
       - decryptionConfig: An instance of ``M_AES_GSM_Configuration``, which specifies parameters for the AES-GCM decryption.
     
     - Note:
     - This method follows three main steps:
       - Derives a cryptographic key from the shared secret using the HMAC-based Extract-and-Expand Key Derivation Function (HKDF), as specified in [RFC 5869](https://datatracker.ietf.org/doc/html/rfc5869).
       - Decrypts the AES-GCM encrypted message and returns the original plaintext.
     
     - Returns: Returns a ``Data`` object containing the decrypted message.
     */
    static func decrypt(key: Data, derivationConfig: M_HKDF_Configuration, decryptionConfig: M_AES_GSM_Configuration) throws -> Data {
        let derivationResult = try deriveKey(key: key, configuration: derivationConfig)
        return try decrypt(secret: derivationResult.derivedKey, configuration: decryptionConfig)
    }
    
    /**
     Performs **AES-GCM** decryption using a pre-derived symmetric key.
     
     
     - Parameters:
       - secret: A pre-derived symmetric key ``Data`` used for AES-GCM encryption.
       - configuration: An instance of ``M_AES_GSM_Configuration``, which specifies parameters for the AES-GCM decryption.
     
     - Note:
     - This function is designed for cases where the decryption key is already derived, either via HKDF or another key exchange mechanism. It ensures both confidentiality and integrity verification of the encrypted data.
     
     - Returns: Returns a ``Data`` object containing the decrypted message.
     */
    static func decrypt(secret: Data, configuration: M_AES_GSM_Configuration) throws -> Data {
        try AES_GCM_Decrypter(secret: secret, configuration: configuration).decrypt()
    }
}
