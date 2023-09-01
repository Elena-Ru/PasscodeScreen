//
//  PasscodeRouter.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-31.
//
import UIKit

protocol PasscodeRouting {
    func navigateToNextScreen()
}

class PasscodeRouter: PasscodeRouting {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func navigateToNextScreen() {
        let nextViewController = SecondViewController()  
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

