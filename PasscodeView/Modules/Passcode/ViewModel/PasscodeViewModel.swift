//
//  PasscodeViewModel.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import Foundation
import Combine

// MARK: - PasscodeViewModel
class PasscodeViewModel: ObservableObject {
    
    // MARK: Properties
    @Published private(set) var passcode = Passcode()
    var passcodeCheckResult = PassthroughSubject<Bool, Never>()
    private let checkPasscodePublisher = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    private let passcodeManager: PasscodeManagerProtocol

    // MARK: Initializer
    init(passcodeManager: PasscodeManagerProtocol) {
        self.passcodeManager = passcodeManager
        self.passcodeManager.save(passcode: Constants.passcode)
        setupBindings()
    }

    // MARK: Methods
    func appendDigit(_ digit: String) {
        if passcode.digits.count < Constants.passcodeDigitCount {
            passcode.digits.append(digit)
            if passcode.digits.count == Constants.passcodeDigitCount {
                checkPasscodePublisher.send(())
            }
        }
    }

    func deleteLastDigit() {
        if passcode.digits.count > .zero {
            passcode.digits.removeLast()
        }
    }
}

// MARK: - PasscodeViewModel
private extension PasscodeViewModel {
    func setupBindings() {
        checkPasscodePublisher
            .delay(for: .seconds(Constants.delay), scheduler: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self else { return }
                self.checkPasscode()
            }
            .store(in: &cancellables)
    }
    
    func checkPasscode() {
        let enteredPasscode = passcode.digits.joined()
        let isValid = passcodeManager.validate(passcode: enteredPasscode)
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.delay) { [weak self] in
            guard let self = self else { return }
            self.passcodeCheckResult.send(isValid)
            self.passcode.digits = []
        }
    }
}

// MARK: - Constants
private extension PasscodeViewModel {
    enum Constants {
        static let passcodeDigitCount: Int = 4
        static let passcode: String = "1111"
        static let delay: Double = 0.5
    }
}
