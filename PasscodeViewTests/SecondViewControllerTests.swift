////
////  SecondViewControllerTests.swift
////  PasscodeViewTests
////
////  Created by Елена Русских on 2023-09-01.
////
//
//import XCTest
//@testable import PasscodeView
//
//class SecondViewControllerTests: XCTestCase {
//
//    var viewController: SecondViewController!
//
//    override func setUpWithError() throws {
//        try super.setUpWithError()
//        viewController = SecondViewController()
//        _ = viewController.view
//    }
//
//    override func tearDownWithError() throws {
//        viewController = nil
//        try super.tearDownWithError()
//    }
//  
//    func test_controllerInitialization() {
//        XCTAssertNotNil(viewController, "SecondViewController should be initialized")
//    }
//
//    func test_backgroundColorSet() {
//        let expectedColor = UIColor.systemRed.cgColor.components
//        let actualColor = viewController.view.backgroundColor?.cgColor.components
//    
//        XCTAssertEqual(expectedColor, actualColor, "Background color should be set to systemRed")
//    }
//
//}
