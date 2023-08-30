//
//  PasscodeViewModel.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import Foundation
import Combine

class PasscodeViewModel: ObservableObject {
    
    @Published var passcode = Passcode()
    private var cancellables = Set<AnyCancellable>()
    
    func appendDigit(_ digit: String) {
        if passcode.digits.count < 4 {
          passcode.digits.append(digit)
        }
    }
    
    func deleteLastDigit() {
        if passcode.digits.count > 0 {
          passcode.digits.removeLast()
        }
    }
}
