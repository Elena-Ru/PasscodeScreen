//
//  PasscodeViewModel.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import Foundation
import Combine

class PasscodeViewModel: ObservableObject {

    @Published private(set) var passcode = Passcode()
    var passcodeCheckResult = PassthroughSubject<Bool, Never>()
    var invalidPasscodeAlertPublisher = PassthroughSubject<Void, Never>()
    private let checkPasscodePublisher = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()

    init() {
        setupBindings()
    }

    private func setupBindings() {
        checkPasscodePublisher
            .delay(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] in
                self?.checkPasscode()
            }
            .store(in: &cancellables)
    }

    func appendDigit(_ digit: String) {
        if passcode.digits.count < 4 {
            passcode.digits.append(digit)

            if passcode.digits.count == 4 {
                checkPasscodePublisher.send(())
            }
        }
    }

    private func checkPasscode() {
      let enteredPasscode = passcode.digits.joined()
      let isValid = PasscodeManager.shared.validate(passcode: enteredPasscode)
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
        if isValid {
          self?.passcodeCheckResult.send(isValid)
        } else {
          self?.invalidPasscodeAlertPublisher.send(())
          self?.passcode.digits = []
        }
      }
    }


    func deleteLastDigit() {
        if passcode.digits.count > 0 {
            passcode.digits.removeLast()
        }
    }
}
