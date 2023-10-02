//
//  PasscodeViewUITests.swift
//  PasscodeViewUITests
//
//  Created by Елена Русских on 2023-09-01.
//

import XCTest
@testable import PasscodeView

final class PasscodeViewUITests: XCTestCase {
  
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
      
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func testPasscodeViewController_WhenViewLoaded_RequiredUIElementsAreEnabled() throws {

        let fisrtButton = app.buttons["1"]
        let secondButton = app.buttons["2"]
        let thirdButton = app.buttons["3"]
        let fourthButton = app.buttons["4"]
        let fifthButton = app.buttons["5"]
        let sixthButton = app.buttons["6"]
        let seventhButton = app.buttons["7"]
        let eighthButton = app.buttons["8"]
        let ninethxButton = app.buttons["9"]
        let zeroButton = app.buttons["0"]
        let backspaceButton = app.buttons["backspace"]
      
        XCTAssertTrue(fisrtButton.isEnabled, "First button is not enabled for user interactions")
        XCTAssertTrue(secondButton.isEnabled, "Second button is not enabled for user interactions")
        XCTAssertTrue(thirdButton.isEnabled, "Third button is not enabled for user interactions")
        XCTAssertTrue(fourthButton.isEnabled, "Fourth button is not enabled for user interactions")
        XCTAssertTrue(fifthButton.isEnabled, "Fifth button is not enabled for user interactions")
        XCTAssertTrue(sixthButton.isEnabled, "Sixth button is not enabled for user interactions")
        XCTAssertTrue(seventhButton.isEnabled, "Seventh button is not enabled for user interactions")
        XCTAssertTrue(eighthButton.isEnabled, "Eighth button is not enabled for user interactions")
        XCTAssertTrue(ninethxButton.isEnabled, "Nineth button is not enabled for user interactions")
        XCTAssertTrue(zeroButton.isEnabled, "Zero button is not enabled for user interactions")
        XCTAssertTrue(backspaceButton.isEnabled, "Backspace button is not enabled for user interactions")

    }

    func testPasscodeViewController_WhenInvalidPasscode_PresentsAlertDialog() throws {
        // Given
        let fisrtButton = app.buttons["1"]
        let secondButton = app.buttons["2"]
        // When
        fisrtButton.tap()
        secondButton.tap()
        secondButton.tap()
        secondButton.tap()
        // Then
        XCTAssertTrue(app.alerts["Error"].waitForExistence(timeout: 1), "An Error Alert dialog was not presented when invalid passcode was entered")
    }
  
    func testPasscodeViewController_UIChangesWhenEnteringPasscode() throws {
        // Given
        let firstCircle = app.otherElements["circle0"]
        let fisrtButton = app.buttons["1"]
        // When
        fisrtButton.tap()
        // Then
        XCTAssertEqual(firstCircle.value as? String, "filled", "First circle did not change to filled after entering a digit")
    }
  
    func testPasscodeViewController_DeleteButtonRemovesLastDigit() throws {
        // Given
        let firstCircle = app.otherElements["circle0"]
        let fisrtButton = app.buttons["1"]
        let backspaceButton = app.buttons["backspace"]
        // When
        fisrtButton.tap()
        backspaceButton.tap()
        // Then
        XCTAssertEqual(firstCircle.value as? String, "empty", "Backspace did not clear the entered digit")
    }
  
    func testPasscodeViewController_SuccessfulPinEntryNavigatesToSecondScreen() throws {
        // Given
        let firstButton = app.buttons["1"]
        // When
        firstButton.tap()
        firstButton.tap()
        firstButton.tap()
        firstButton.tap()
        // Then
        let secondScreen = app.otherElements["coloredScreen"]
        XCTAssertTrue(secondScreen.waitForExistence(timeout: 1.0), "After entering a correct pin, the user should navigate to the colored screen within 1 second.")
    }
  
    func testPasscodeViewController_MultipleDeleteClearsCirclesCorrectly() throws {
        // Given
        let firstButton = app.buttons["1"]
        let secondButton = app.buttons["2"]
        let thirdButton = app.buttons["3"]
        let backspaceButton = app.buttons["backspace"]
    
        let firstCircle = app.otherElements["circle0"]
        let secondCircle = app.otherElements["circle1"]
        let thirdCircle = app.otherElements["circle2"]
  
        // When
        firstButton.tap()
        secondButton.tap()
        thirdButton.tap()
        // Then
        XCTAssertEqual(firstCircle.value as? String, "filled", "First circle did not fill after entering a digit")
        XCTAssertEqual(secondCircle.value as? String, "filled", "Second circle did not fill after entering a digit")
        XCTAssertEqual(thirdCircle.value as? String, "filled", "Third circle did not fill after entering a digit")
        // When
        backspaceButton.tap()
        backspaceButton.tap()
        // Then
        XCTAssertEqual(firstCircle.value as? String, "filled", "First circle should remain filled after deleting two digits")
        XCTAssertEqual(secondCircle.value as? String, "empty", "Second circle did not clear after deleting a digit")
        XCTAssertEqual(thirdCircle.value as? String, "empty", "Third circle did not clear after deleting a digit")
        // When
        backspaceButton.tap()
        // Then
        XCTAssertEqual(firstCircle.value as? String, "empty", "First circle did not clear after deleting the last digit")
    }
  
  func testPasscodeViewController_ClearsPinAfterInvalidEntry() throws {
      // Given
      let firstButton = app.buttons["1"]
      let secondButton = app.buttons["2"]
      let thirdButton = app.buttons["3"]
      let fourthButton = app.buttons["4"]

      let firstCircle = app.otherElements["circle0"]
      let secondCircle = app.otherElements["circle1"]
      let thirdCircle = app.otherElements["circle2"]
      let fourthCircle = app.otherElements["circle3"]
      // When
      firstButton.tap()
      secondButton.tap()
      thirdButton.tap()
      fourthButton.tap()
      // Then
      XCTAssertTrue(app.alerts["Error"].waitForExistence(timeout: 1), "An Error Alert dialog was not presented when invalid passcode was entered")

      app.alerts["Error"].buttons["OK"].tap()

      // Then
      XCTAssertEqual(firstCircle.value as? String, "empty", "First circle did not clear after an invalid passcode entry")
      XCTAssertEqual(secondCircle.value as? String, "empty", "Second circle did not clear after an invalid passcode entry")
      XCTAssertEqual(thirdCircle.value as? String, "empty", "Third circle did not clear after an invalid passcode entry")
      XCTAssertEqual(fourthCircle.value as? String, "empty", "Fourth circle did not clear after an invalid passcode entry")
  }
}
