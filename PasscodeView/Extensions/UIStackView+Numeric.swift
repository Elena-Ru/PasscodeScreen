//
//  UIStackView+Numeric.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import UIKit

extension UIStackView {
    static func createNumericStackView() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }
}
