//
//  RoundViewExtention.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import UIKit

extension UIView {
  func makeRounded(borderColor: UIColor, borderWidth: CGFloat) {
    layer.cornerRadius = 10
    layer.borderColor = borderColor.cgColor
    layer.borderWidth = borderWidth
  }
}
