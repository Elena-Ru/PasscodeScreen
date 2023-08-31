//
//  PasscodeManager.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import Foundation

protocol PasscodeManagerProtocol {
    func validate(passcode: String) -> Bool
}

final class PasscodeManager: PasscodeManagerProtocol {
    static let shared = PasscodeManager()
    private init() {}
    
    var storedPasscode: String = "1111"
  
    func validate(passcode: String) -> Bool {
      return passcode == storedPasscode
    }
}
