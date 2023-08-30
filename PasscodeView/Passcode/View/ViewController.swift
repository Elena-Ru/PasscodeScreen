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
    bindToRootViewEvents()
    bindViewModel()
  }
  
  private func bindViewModel() {
       viewModel.$passcode
           .sink { [weak self] passcode in
               self?.updateUIForPasscode(passcode)
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

  private func bindToRootViewEvents() {
    rootView.numericButtonPublisher
      .sink { [weak self] number in
        self?.handleNumericButtonTap(number)
      }
      .store(in: &cancellables)
    
    rootView.deleteButtonPublisher
      .sink { [weak self] in
        self?.handleDeleteButtonTap()
      }
      .store(in: &cancellables)
  }
  
  private func handleNumericButtonTap(_ number: String) {
//    if let emptyCircle = rootView.circles.first(where: { $0.backgroundColor != .brightCoral }) {
//      emptyCircle.backgroundColor = .brightCoral
//    }
    viewModel.appendDigit(number)
  }
  
  private func handleDeleteButtonTap() {
//    if let fillCircle = rootView.circles.last(where: { $0.backgroundColor != .clear }) {
//      fillCircle.backgroundColor = .clear
//    }
    viewModel.deleteLastDigit()
  }

}

