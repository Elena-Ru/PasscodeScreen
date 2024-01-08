//
//  Texts.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-31.
//

import Foundation

enum Texts {
    
    enum ViewController {
        static var title: String { NSLocalizedString("passcode_title", comment: "") }
    }
    
    enum Alert {
        static var title: String { NSLocalizedString("error_alert_title", comment: "") }
        static var message: String { NSLocalizedString("error_alert_message", comment: "") }
        static var okButton: String { NSLocalizedString("ok", comment: "") }
    }
}
