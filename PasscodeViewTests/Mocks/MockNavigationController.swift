//
//  MockNavigationController.swift
//  PasscodeViewTests
//
//  Created by Елена Русских on 2023-09-01.
//

import Foundation
import UIKit

class MockNavigationController: UINavigationController {
    var didPushViewController = false
    var pushedViewController: UIViewController?
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        didPushViewController = true
        pushedViewController = viewController
    }
}
