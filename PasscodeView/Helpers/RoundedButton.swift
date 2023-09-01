//
//  RoundedButton.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import UIKit

class RoundedButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
     init(title: String) {
        super.init(frame: .zero)
        layer.backgroundColor = UIColor.clear.cgColor
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        layer.cornerRadius = 30
        layer.borderColor = UIColor.lightGrayBorder.cgColor
        layer.borderWidth = 2.0
        translatesAutoresizingMaskIntoConstraints = false
        accessibilityIdentifier = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
