//
//  PasscodeManagerProtocol.swift
//  PasscodeView
//
//  Created by Елена Русских on 2024-01-08.
//

// MARK: - PasscodeManagerProtocol
protocol PasscodeManagerProtocol {
    func save(passcode: String) -> Bool
    func validate(passcode: String) -> Bool
}
