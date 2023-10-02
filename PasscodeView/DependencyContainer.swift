//
//  DependencyContainer.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-09-18.
//

import Swinject

class AppDependencyContainer {
    let container: Container

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
