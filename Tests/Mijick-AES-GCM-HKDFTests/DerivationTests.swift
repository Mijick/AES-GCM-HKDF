//
//  DerivationTests.swift
//  AESGCMHKDFTests
//
//  Created by Alina Petrovska on 16.02.2025.
//

import Testing
import CryptoKit
@testable import MijickGCM_HKDF

struct DerivationTests { }

extension DerivationTests {
    @Test("Basic test case with SHA-256") func sha256_basic() throws {
        let config: DerivationVectors = .basicSHA256
        let hkdfConfig = M_HKDF_Configuration(hashVariant: .sha256,
                                              salt: config.salt,
                                              info: config.info,
                                              length: 42)
        let derivator = HKDF_KeyDerivator(key: config.key, configuration: hkdfConfig)
        let data = try derivator.derive()
        #expect(data.hexString == config.expected)
    }
    @Test("Test with SHA-256 and longer inputs/outputs") func sha256_longer_inputs_outputs() throws {
        let config: DerivationVectors = .longerSHA256
        let hkdfConfig = M_HKDF_Configuration(hashVariant: .sha256,
                                              salt: config.salt,
                                              info: config.info,
                                              length: 82)
        let derivator = HKDF_KeyDerivator(key: config.key, configuration: hkdfConfig)
        let data = try derivator.derive()
        #expect(data.hexString == config.expected)
    }
    @Test("Test with SHA-256 and zero-length salt/info") func sha256_zero_salt_info() throws {
        let config: DerivationVectors = .zeroSHA256
        let hkdfConfig = M_HKDF_Configuration(hashVariant: .sha256,
                                              salt: config.salt,
                                              info: config.info,
                                              length: 42)
        let derivator = HKDF_KeyDerivator(key: config.key, configuration: hkdfConfig)
        let data = try derivator.derive()
        #expect(data.hexString == config.expected)
    }
}

// SHA-1
extension DerivationTests {
    @Test("Basic test case with SHA-1") func sha1_basic() throws {
        let config: DerivationVectors = .basicSHA1
        let hkdfConfig = M_HKDF_Configuration(hashVariant: .sha1,
                                              salt: config.salt,
                                              info: config.info,
                                              length: 42)
        let derivator = HKDF_KeyDerivator(key: config.key, configuration: hkdfConfig)
        let data = try derivator.derive()
        #expect(data.hexString == config.expected)
    }
    @Test("Test with SHA-1 and longer inputs/outputs") func sha1_longer_inputs_outputs() throws {
        let config: DerivationVectors = .longerSHA1
        let hkdfConfig = M_HKDF_Configuration(hashVariant: .sha1,
                                              salt: config.salt,
                                              info: config.info,
                                              length: 82)
        let derivator = HKDF_KeyDerivator(key: config.key, configuration: hkdfConfig)
        let data = try derivator.derive()
        #expect(data.hexString == config.expected)
    }
    @Test("Test with SHA-1 and zero-length salt/info") func sha1_zero_salt_info() throws {
        let config: DerivationVectors = .zeroSHA1
        let hkdfConfig = M_HKDF_Configuration(hashVariant: .sha1,
                                              salt: config.salt,
                                              info: config.info,
                                              length: 42)
        let derivator = HKDF_KeyDerivator(key: config.key, configuration: hkdfConfig)
        let data = try derivator.derive()
        #expect(data.hexString == config.expected)
    }
    @Test("Test with SHA-1, salt not provided (defaults to HashLen zero octets), zero-length info") func sha1_no_salt() throws {
        let config: DerivationVectors = .noSaltSHA1
        let hkdfConfig = M_HKDF_Configuration(hashVariant: .sha1,
                                              salt: config.salt,
                                              info: config.info,
                                              length: 42)
        let derivator = HKDF_KeyDerivator(key: config.key, configuration: hkdfConfig)
        let data = try derivator.derive()
        #expect(data.hexString == config.expected)
    }
}
