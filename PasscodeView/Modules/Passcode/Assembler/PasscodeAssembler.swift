//
//  PasscodeAssembler.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import Foundation
import UIKit

protocol PasscodeAssembler {
    func resolveNavigationController() -> UINavigationController
    func resolveViewModel() -> PasscodeViewModel
}

class PasscodeAssemblerImpl: PasscodeAssembler {
    func resolveNavigationController() -> UINavigationController {
        let viewController = ViewController()
        viewController.viewModel = resolveViewModel()
        let navigationController = UINavigationController(rootViewController: viewController)
        let router = PasscodeRouter(navigationController: navigationController)
        viewController.router = router
        return navigationController
    }
    
    func resolveViewModel() -> PasscodeViewModel {
        return PasscodeViewModel()
    }
}
