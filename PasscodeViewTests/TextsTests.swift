//
//  TextsTests.swift
//  PasscodeViewTests
//
//  Created by Елена Русских on 2023-09-01.
//

import XCTest
@testable import PasscodeView

class TextsTests: XCTestCase {

    func test_ViewControllerTitle() {
        let expectedText = NSLocalizedString("passcode_title", comment: "")
        XCTAssertEqual(Texts.ViewController.title, expectedText)
    }
    
    func test_AlertTitle() {
        let expectedText = NSLocalizedString("error_alert_title", comment: "")
        XCTAssertEqual(Texts.Alert.title, expectedText)
    }
    
    func test_AlertMessage() {
        let expectedText = NSLocalizedString("error_alert_message", comment: "")
        XCTAssertEqual(Texts.Alert.message, expectedText)
    }
    
    func test_AlertOkButton() {
        let expectedText = NSLocalizedString("ok", comment: "")
        XCTAssertEqual(Texts.Alert.ok_button, expectedText)
    }
}
