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
        // Регистрация сервиса для управления паролем
        container.register(PasscodeManagerProtocol.self) { _ in
            PasscodeManager.shared
        }

        // Регистрация ViewModel с инъекцией зависимости PasscodeManager
        container.register(PasscodeViewModel.self) { r in
            let passcodeManager = r.resolve(PasscodeManagerProtocol.self)!
            return PasscodeViewModel(passcodeManager: passcodeManager)
        }
    }
}
