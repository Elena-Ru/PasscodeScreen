//
//  PasscodeManagerTests.swift
//  PasscodeViewTests
//
//  Created by Елена Русских on 2023-09-01.
//

import XCTest
@testable import PasscodeView

class PasscodeManagerTests: XCTestCase {
    var passcodeManager: PasscodeManager!

    override func setUpWithError() throws {
        passcodeManager = PasscodeManager.shared
    }

    override func tearDownWithError() throws {
        passcodeManager = nil
    }

    func test_validateCorrectPasscode() {
        XCTAssertTrue(passcodeManager.validate(passcode: "1111"), "Function should return true for correct passcode")
    }

    func test_validateIncorrectPasscode() {
        XCTAssertFalse(passcodeManager.validate(passcode: "1234"), "Function should return false for incorrect passcode")
    }
}
