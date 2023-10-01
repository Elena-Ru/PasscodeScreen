//
//  PasscodeViewController.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import UIKit
import Combine

class PasscodeViewController: UIViewController {

    var rootView = RootView()
    var viewModel: PasscodeViewModel?
    private var cancellables = Set<AnyCancellable>()
    var router: PasscodeRouting!

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
        viewModel?.$passcode
            .sink { [weak self] passcode in
                self?.updateUIForPasscode(passcode)
            }
            .store(in: &cancellables)

        viewModel?.passcodeCheckResult
            .sink { [weak self] isValid in
                if isValid {
                    self?.router.navigateToNextScreen()
                } else {
                    self?.showInvalidPasscodeAlert()
                }
            }
            .store(in: &cancellables)

        rootView.numericButtonPublisher
            .sink { [weak self] number in
                self?.viewModel?.appendDigit(number)
            }
            .store(in: &cancellables)

        rootView.deleteButtonPublisher
            .sink { [weak self] in
                self?.viewModel?.deleteLastDigit()
            }
            .store(in: &cancellables)
    }

    private func updateUIForPasscode(_ passcode: Passcode) {
        for (index, circle) in rootView.circles.enumerated() {
            if index < passcode.digits.count {
                circle.backgroundColor = .brightCoral
                circle.accessibilityValue = "filled"
            } else {
                circle.backgroundColor = .clear
                circle.accessibilityValue = "empty"
            }
        }
    }
  
    private func showInvalidPasscodeAlert() {
      let alertController = UIAlertController(title: L10n.errorAlertTitle,
                                              message: L10n.errorAlertMessage,
                                                preferredStyle: .alert)
      let okAction = UIAlertAction(title: L10n.ok, style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
