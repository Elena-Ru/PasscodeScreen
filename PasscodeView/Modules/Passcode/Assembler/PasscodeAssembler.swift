//
//  PasscodeAssembler.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import UIKit

// MARK: - PasscodeAssembler
protocol PasscodeAssembler {
    func assemblePasscodeStack() -> UINavigationController
}

// MARK: - PasscodeAssemblerImpl
final class PasscodeAssemblerImpl: PasscodeAssembler {
    func assemblePasscodeStack() -> UINavigationController {
        let container = AppDependencyContainer().container
        
        let viewController = PasscodeViewController()
        viewController.viewModel = container.resolve(PasscodeViewModel.self)
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.router = container.resolve(PasscodeRouting.self, argument: navigationController)
        return navigationController
    }

}
