//
//  DependencyContainer.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-09-18.
//

import Swinject

// MARK: - AppDependencyContainer
final class AppDependencyContainer {
    
    // MARK: Properties
    let container: Container

    // MARK: Initializer
    init() {
        container = Container()
        registerDependencies()
    }

    private func registerDependencies() {
        container.register(PasscodeManagerProtocol.self) { _ in
            PasscodeManager.shared
        }

        container.register(PasscodeViewModel.self) { r in
            let passcodeManager = r.resolve(PasscodeManagerProtocol.self)!
            return PasscodeViewModel(passcodeManager: passcodeManager)
        }
      
        container.register(PasscodeRouting.self) { (_, navigationController: UINavigationController) in
            PasscodeRouter(navigationController: navigationController)
        }
    }
}
