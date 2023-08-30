//
//  RootView.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import UIKit
import SnapKit

class RootView: UIView {
  
    struct LayoutConstants {
        static let circleSize: CGFloat = 20
        static let numericButtonSize: CGFloat = 60
    }
  
    let centralNumericTitles = ["2", "5", "8", "0"]
    let leftNumericTitles = ["1", "4", "7"]
    let rightNumericTitles = ["3", "6", "9"]
    var circles: [UIView] = []
    var numericButtons: [UIButton] = []
    //MARK: - Views
    
    let enterPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter Password"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = LayoutConstants.circleSize
        return stack
    }()
  
    let numericCentralStackView: UIStackView = .createNumericStackView()
    let numericLeftStackView: UIStackView = .createNumericStackView()
    let numericRightStackView: UIStackView = .createNumericStackView()
    
    //MARK: - Inits
    init() {
        super.init(frame: CGRect())
        createCircles(count: 4)
        createNumericButtons()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func createCircles(count: Int) {
        for _ in 0..<count {
            let circle = createCircle()
            circles.append(circle)
            stackView.addArrangedSubview(circle)
            circle.snp.makeConstraints { make in
              make.width.height.equalTo(LayoutConstants.circleSize)
            }
            circle.makeRounded(borderColor: .lightGrayBorder, borderWidth: 2)
        }
    }
    
    private func createCircle() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brightCoral
        return view
    }
  
    private func createNumericButtons() {
      createButtons(for: numericCentralStackView, titles: centralNumericTitles)
      createButtons(for: numericLeftStackView, titles: leftNumericTitles)
      createButtons(for: numericRightStackView, titles: rightNumericTitles)
    }
  
    private func createButtons(for stackView: UIStackView, titles: [String]) {
         for title in titles {
             let button = RoundedButton(title: title)
             numericButtons.append(button)
             stackView.addArrangedSubview(button)
             button.snp.makeConstraints { make in
                 make.width.height.equalTo(LayoutConstants.numericButtonSize)
             }
         }
     }
  
    private func setupLayout() {
        addSubview(enterPasswordLabel)
        addSubview(stackView)
        addSubview(numericCentralStackView)
        addSubview(numericLeftStackView)
        addSubview(numericRightStackView)
      
        enterPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalTo(self)
        }
        
        stackView.snp.makeConstraints { make in
            make.width.equalTo(180)
            make.height.equalTo(LayoutConstants.circleSize)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalTo(self)
        }
      
        numericCentralStackView.snp.makeConstraints { make in
            make.width.equalTo(LayoutConstants.numericButtonSize)
            make.height.equalTo(290)
            make.top.equalTo(stackView.snp.bottom).offset(250)
            make.centerX.equalTo(self)
        }
      
        numericLeftStackView.snp.makeConstraints { make in
            make.width.equalTo(LayoutConstants.numericButtonSize)
            make.height.equalTo(210)
            make.top.equalTo(stackView.snp.bottom).offset(250)
            make.centerX.equalTo(numericCentralStackView.snp.leading).offset(-LayoutConstants.numericButtonSize)
        }
      
        numericRightStackView.snp.makeConstraints { make in
            make.width.equalTo(LayoutConstants.numericButtonSize)
            make.height.equalTo(210)
            make.top.equalTo(stackView.snp.bottom).offset(250)
            make.centerX.equalTo(numericCentralStackView.snp.trailing).offset(LayoutConstants.numericButtonSize)
        }
    }
}
