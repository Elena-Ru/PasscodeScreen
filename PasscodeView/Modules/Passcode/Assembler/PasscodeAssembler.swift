//
//  PasscodeAssembler.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import Foundation
import UIKit

protocol PasscodeAssembler {
    func assemblePasscodeStack() -> UINavigationController
    func resolveViewModel() -> PasscodeViewModel
}

class PasscodeAssemblerImpl: PasscodeAssembler {
    func assemblePasscodeStack() -> UINavigationController {
        let viewController = PasscodeViewController()
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
