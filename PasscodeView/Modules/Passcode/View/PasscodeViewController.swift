//
//  PasscodeViewController.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import UIKit
import Combine

// MARK: - PasscodeViewController
final class PasscodeViewController: UIViewController {

    // MARK: Properties
    let rootView = RootView()
    var viewModel: PasscodeViewModel?
    private var cancellables = Set<AnyCancellable>()
    var router: PasscodeRouting!

    // MARK: Life cycle
    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkIndigo
        bindViewModel()
    }
}

// MARK: - Bind
private extension PasscodeViewController {
    func bindViewModel() {
        viewModel?.$passcode
            .sink { [weak self] passcode in
                guard let self = self else { return }
                self.updateUIForPasscode(passcode)
            }
            .store(in: &cancellables)

        viewModel?.passcodeCheckResult
            .sink { [weak self] isValid in
                guard let self = self else { return }
                if isValid {
                    self.router.navigateToNextScreen()
                } else {
                    self.showInvalidPasscodeAlert()
                }
            }
            .store(in: &cancellables)

        rootView.numericButtonPublisher
            .sink { [weak self] number in
                guard let self = self else { return }
                self.viewModel?.appendDigit(number)
            }
            .store(in: &cancellables)

        rootView.deleteButtonPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.viewModel?.deleteLastDigit()
            }
            .store(in: &cancellables)
    }
}

// MARK: - Private Methods
private extension PasscodeViewController {
    func updateUIForPasscode(_ passcode: Passcode) {
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
  
    func showInvalidPasscodeAlert() {
      let alertController = UIAlertController(title: L10n.errorAlertTitle,
                                              message: L10n.errorAlertMessage,
                                              preferredStyle: .alert)
      let okAction = UIAlertAction(title: L10n.ok, style: .default)
      alertController.addAction(okAction)
      present(alertController, animated: true)
    }
}
