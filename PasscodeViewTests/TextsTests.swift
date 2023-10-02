//
//  TextsTests.swift
//  PasscodeViewTests
//
//  Created by Елена Русских on 2023-09-01.
//

import XCTest
@testable import PasscodeView

final class TextsTests: XCTestCase {

    func test_ViewControllerTitle() {
        let expectedText = NSLocalizedString("passcode_title", comment: "")
        XCTAssertEqual(L10n.passcodeTitle, expectedText)
    }
    
    func test_AlertTitle() {
        let expectedText = NSLocalizedString("error_alert_title", comment: "")
        XCTAssertEqual(L10n.errorAlertTitle, expectedText)
    }
    
    func test_AlertMessage() {
        let expectedText = NSLocalizedString("error_alert_message", comment: "")
        XCTAssertEqual(L10n.errorAlertMessage, expectedText)
    }
    
    func test_AlertOkButton() {
        let expectedText = NSLocalizedString("ok", comment: "")
        XCTAssertEqual(L10n.ok, expectedText)
    }
}
