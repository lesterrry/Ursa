//
//  Security.swift
//  Ursa
//
//  Created by aydar.media on 30.07.2023.
//

import Foundation

struct KeychainEntity {
    public static let serviceName = Bundle.main.bundleIdentifier!
    public enum Account: String {
        case deviceId = "DEVICE_ID"
        case appSecret = "APP_SECRET"
        case appId = "APP_ID"
        case userLogin = "USER_LOGIN"
        case userPassword = "USER_PASSWORD"
    }
}
