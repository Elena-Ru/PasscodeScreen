//
//  ViewController.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import UIKit
import Combine

class ViewController: UIViewController {

    var rootView = RootView()
    var viewModel = PasscodeViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkIndigo
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.$passcode
            .sink { [weak self] passcode in
                self?.updateUIForPasscode(passcode)
            }
            .store(in: &cancellables)

        viewModel.passcodeCheckResult
            .sink { [weak self] isValid in
                if isValid {
                    print("переход")
                } else {
                    print("сброс")
                }
            }
            .store(in: &cancellables)

        rootView.numericButtonPublisher
            .sink { [weak self] number in
                self?.viewModel.appendDigit(number)
            }
            .store(in: &cancellables)

        rootView.deleteButtonPublisher
            .sink { [weak self] in
                self?.viewModel.deleteLastDigit()
            }
            .store(in: &cancellables)
    }

    private func updateUIForPasscode(_ passcode: Passcode) {
        for (index, circle) in rootView.circles.enumerated() {
            if index < passcode.digits.count {
                circle.backgroundColor = .brightCoral
            } else {
                circle.backgroundColor = .clear
            }
        }
    }
}
