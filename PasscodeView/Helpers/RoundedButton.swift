//
//  RoundedButton.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import UIKit

// MARK: - RoundedButton
class RoundedButton: UIButton {
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
     init(title: String) {
        super.init(frame: .zero)
        layer.backgroundColor = UIColor.clear.cgColor
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        layer.cornerRadius = Constants.cornerRadius
        layer.borderColor = UIColor.lightGrayBorder.cgColor
        layer.borderWidth = Constants.borderWidth
        translatesAutoresizingMaskIntoConstraints = false
        accessibilityIdentifier = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constants
private extension RoundedButton {
    enum Constants {
        static let borderWidth: CGFloat = 2.0
        static let cornerRadius: CGFloat = 30
        static let fontSize: CGFloat = 20
    }
}
