////
////  PasscodeViewTests.swift
////  PasscodeViewTests
////
////  Created by Елена Русских on 2023-08-31.
////
//
//import XCTest
//import Combine
//@testable import PasscodeView
//
//final class PasscodeViewModelTests: XCTestCase {
//
//    var viewModel: PasscodeViewModel!
//    var mockPasscodeManager: MockPasscodeManager!
//    private var cancellables: Set<AnyCancellable> = []
//  
//    override func setUpWithError() throws {
//        super.setUp()
//        mockPasscodeManager = MockPasscodeManager()
//        viewModel = PasscodeViewModel(passcodeManager: mockPasscodeManager)
//    }
//
//    override func tearDownWithError() throws {
//        viewModel = nil
//        mockPasscodeManager = nil
//        try super.tearDownWithError()
//    }
//
//    func test_appendDigit() {
//        // When
//        viewModel.appendDigit("1")
//        // Then
//        XCTAssertEqual(viewModel.passcode.digits, ["1"], "After appending '1', the passcode digits should only contain ['1']")
//    }
//  
//    func test_appendMoreThanFourDigits_shouldAppendOnly4Digits() {
//        // When
//        viewModel.appendDigit("1")
//        viewModel.appendDigit("2")
//        viewModel.appendDigit("3")
//        viewModel.appendDigit("4")
//        viewModel.appendDigit("5")
//        // Then
//        XCTAssertEqual(viewModel.passcode.digits, ["1", "2", "3", "4"], "Passcode digits should not contain more than 4 digits")
//    }
//  
//    func test_deleteLastDigit() {
//        // Given
//        viewModel.appendDigit("1")
//        viewModel.appendDigit("2")
//        // When
//        viewModel.deleteLastDigit()
//        // Then
//        XCTAssertEqual(viewModel.passcode.digits, ["1"], "After deleting the last digit, the passcode digits should only contain ['1']")
//    }
//  
//    func test_correctPasscodeEntry() {
//        // Given
//        var passcodeCheckResult = false
//        let expectation = self.expectation(description: "Wait for passcode check result")
//  
//        viewModel.passcodeCheckResult
//            .sink(receiveValue: { result in
//                passcodeCheckResult = result
//                expectation.fulfill()
//            })
//            .store(in: &cancellables)
//        // When
//        for _ in 0...4 {
//          viewModel.appendDigit("1")
//        }
//        // Then
//        waitForExpectations(timeout: 2.0, handler: nil)
//        XCTAssertTrue(passcodeCheckResult, "After entering the correct passcode, passcodeCheckResult should be true")
//    }
//
//    func test_incorrectPasscodeEntry() {
//        // Given
//        var passcodeCheckResult = false
//        mockPasscodeManager.mockedResult = false
//        let expectation = self.expectation(description: "Wait for passcode check result")
//  
//        viewModel.passcodeCheckResult
//            .sink(receiveValue: { result in
//                passcodeCheckResult = result
//                expectation.fulfill()
//            })
//            .store(in: &cancellables)
//        // When
//        viewModel.appendDigit("1")
//        viewModel.appendDigit("2")
//        viewModel.appendDigit("3")
//        viewModel.appendDigit("5")
//        // Then
//        waitForExpectations(timeout: 2.0, handler: nil)
//        XCTAssertFalse(passcodeCheckResult, "After entering the incorrect passcode, passcodeCheckResult should be false")
//    }
//}
