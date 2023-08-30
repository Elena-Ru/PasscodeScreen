//
//  ViewController.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import UIKit

class ViewController: UIViewController {

  var rootView = RootView()
  
  override func loadView() {
      super.loadView()
      view = rootView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .darkIndigo
    // Do any additional setup after loading the view.
  }


}

