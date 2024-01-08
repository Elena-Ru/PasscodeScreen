//
//  PasscodeRouter.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-31.
//
import UIKit

// MARK: - PasscodeRouter
final class PasscodeRouter {
    
    // MARK: Properties
    weak var navigationController: UINavigationController?
    
    // MARK: Initializer
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

// MARK: - PasscodeRouting
extension PasscodeRouter: PasscodeRouting {
    func navigateToNextScreen() {
        let nextViewController = SecondViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
