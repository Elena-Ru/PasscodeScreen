//
//  MockPasscodeManager.swift
//  PasscodeViewTests
//
//  Created by Елена Русских on 2023-08-31.
//
@testable import PasscodeView

class MockPasscodeManager: PasscodeManagerProtocol {
    var mockedResult: Bool = true

     func validate(passcode: String) -> Bool {
         return mockedResult
     }
}
