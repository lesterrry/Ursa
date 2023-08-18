//
//  UrsaTests.swift
//  UrsaTests
//
//  Created by aydar.media on 19.08.2023.
//

import XCTest
import KeychainBridge
@testable import Ursa


final class UrsaTests: XCTestCase {

    func testKeychainRead() throws {
        let keychain = Keychain(serviceName: "com.aydarmedia.ursa.widget-default")
        
        XCTAssertNoThrow(try keychain.getToken(account: KeychainEntity.Account.appId.rawValue))
        XCTAssertNoThrow(try keychain.getToken(account: KeychainEntity.Account.appSecret.rawValue))
        XCTAssertNoThrow(try keychain.getToken(account: KeychainEntity.Account.userLogin.rawValue))
        XCTAssertNoThrow(try keychain.getToken(account: KeychainEntity.Account.userPassword.rawValue))
        XCTAssertNoThrow(try keychain.getToken(account: KeychainEntity.Account.deviceId.rawValue))
    }
    
    func testKeychainWrite() throws {
        let keychain = Keychain(serviceName: "com.aydarmedia.ursa.widget-default")
        
        XCTAssertNoThrow(try keychain.saveToken("14751", account: KeychainEntity.Account.appId.rawValue))
        XCTAssertNoThrow(try keychain.saveToken("FpssmfJ3rVKohqNud27tNQsyPvVDe-88", account: KeychainEntity.Account.appSecret.rawValue))
        XCTAssertNoThrow(try keychain.saveToken("1234", account: KeychainEntity.Account.userLogin.rawValue))
        XCTAssertNoThrow(try keychain.saveToken("4321", account: KeychainEntity.Account.userPassword.rawValue))
        XCTAssertNoThrow(try keychain.saveToken("861292056998348", account: KeychainEntity.Account.deviceId.rawValue))
    }

}
