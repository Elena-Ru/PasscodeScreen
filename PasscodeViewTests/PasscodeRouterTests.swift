////
////  PasscodeRouterTests.swift
////  PasscodeViewTests
////
////  Created by Елена Русских on 2023-09-01.
////
//
//import XCTest
//@testable import PasscodeView
//
//final class PasscodeRouterTests: XCTestCase {
//    
//    var router: PasscodeRouter!
//    var mockNavController: MockNavigationController!
//
//    override func setUpWithError() throws {
//        mockNavController = MockNavigationController()
//        router = PasscodeRouter(navigationController: mockNavController)
//    }
//
//    override func tearDownWithError() throws {
//        router = nil
//        mockNavController = nil
//    }
//
//    func test_initializationWithNavController() {
//        // Then
//        XCTAssertNotNil(router.navigationController, "After initialization, the router's navigationController should not be nil.")
//    }
//
//    func test_navigateToNextScreen() {
//        // When
//        router.navigateToNextScreen()
//        // Then
//        XCTAssertTrue(mockNavController.didPushViewController, "After calling navigateToNextScreen, the pushViewController method should be invoked.")
//        XCTAssertTrue(mockNavController.pushedViewController is SecondViewController, "The passed controller should be an instance of SecondViewController.")
//    }
//}
