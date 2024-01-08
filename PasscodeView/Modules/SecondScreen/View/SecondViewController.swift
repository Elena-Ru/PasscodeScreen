//
//  SecondViewController.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-31.
//

import UIKit

// MARK: - SecondViewController
final class SecondViewController: UIViewController {

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "coloredScreen"
        view.backgroundColor = .systemRed
    }
}
