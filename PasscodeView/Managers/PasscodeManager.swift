//
//  PasscodeManager.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import Foundation
import KeychainSwift

protocol PasscodeManagerProtocol {
    func save(passcode: String) -> Bool
    func validate(passcode: String) -> Bool
}

final class PasscodeManager: PasscodeManagerProtocol {
    static let shared = PasscodeManager()
    private init() {}
    
    private let keychain = KeychainSwift()
    private let keychainKey = "storedPasscode"
    
    func save(passcode: String) -> Bool {
        return keychain.set(passcode, forKey: keychainKey)
    }
    
    func validate(passcode: String) -> Bool {
        guard let storedPasscode = keychain.get(keychainKey) else {
            return false
        }
        return passcode == storedPasscode
    }
}
