//
//  PasscodeManager.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import KeychainSwift

// MARK: - PasscodeManager
final class PasscodeManager {
    // MARK: Properties
    static let shared = PasscodeManager()
    private let keychain = KeychainSwift()
    private let keychainKey = "storedPasscode"
    
    // MARK: Initializer
    private init() {}
}

// MARK: - PasscodeManagerProtocol
extension PasscodeManager: PasscodeManagerProtocol {
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
