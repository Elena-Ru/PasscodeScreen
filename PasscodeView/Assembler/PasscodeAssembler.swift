//
//  PasscodeAssembler.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import Foundation

protocol PasscodeAssembler {
    func resolveViewController() -> ViewController
    func resolveViewModel() -> PasscodeViewModel
}

class PasscodeAssemblerImpl: PasscodeAssembler {
    func resolveViewController() -> ViewController {
        let viewController = ViewController()
        viewController.viewModel = resolveViewModel()
        return viewController
    }
    
    func resolveViewModel() -> PasscodeViewModel {
        return PasscodeViewModel()
    }
}
