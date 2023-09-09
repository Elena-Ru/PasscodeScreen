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
    private let checkPasscodePublisher = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    private let passcodeManager: PasscodeManagerProtocol

    init(passcodeManager: PasscodeManagerProtocol = PasscodeManager.shared) {
           self.passcodeManager = passcodeManager
           self.passcodeManager.save(passcode: "1111")
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
      let isValid = passcodeManager.validate(passcode: enteredPasscode)
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
        self?.passcodeCheckResult.send(isValid)
        self?.passcode.digits = []
      }
    }


    func deleteLastDigit() {
        if passcode.digits.count > 0 {
            passcode.digits.removeLast()
        }
    }
}
