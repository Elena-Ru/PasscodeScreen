//
//  RootView.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import UIKit
import SnapKit
import Combine

class RootView: UIView {
  
    struct LayoutConstants {
        static let circleSize: CGFloat = 20
        static let numericButtonSize: CGFloat = 60
    }
  
    let numericButtonPublisher = PassthroughSubject<String, Never>()
    let deleteButtonPublisher = PassthroughSubject<Void, Never>()
    let centralNumericTitles = ["2", "5", "8", "0"]
    let leftNumericTitles = ["1", "4", "7"]
    let rightNumericTitles = ["3", "6", "9"]
    var circles: [UIView] = []
    var numericButtons: [UIButton] = []
    // MARK: - Views
    
    let enterPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.passcodeTitle
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
  
    lazy var deleteButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "delete.left.fill"), for: .normal)
        btn.tintColor = .white
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.accessibilityIdentifier = "backspace"
        btn.addTarget(self, action: #selector(deleteButtonAction(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    // MARK: - Inits
    init() {
        super.init(frame: CGRect())
        createCircles(count: 4)
        createNumericButtons()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func createCircles(count: Int) {
        for i in 0..<count {
            let circle = createCircle()
          circle.accessibilityIdentifier = "circle\(i)"
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
        view.backgroundColor = .clear
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
             button.addTarget(self, action: #selector(numericButtonTapped(_:)), for: .touchUpInside)
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
        addSubview(deleteButton)
      
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
      
        deleteButton.snp.makeConstraints { make in
            make.height.width.equalTo(LayoutConstants.numericButtonSize)
            make.top.equalTo(numericRightStackView.snp.bottom).offset(20)
            make.centerX.equalTo(numericCentralStackView.snp.trailing).offset(LayoutConstants.numericButtonSize)
        }
    }
  
    // MARK: - Objc methods
    @objc private func numericButtonTapped(_ sender: UIButton) {
         guard let buttonTitle = sender.titleLabel?.text else { return }
         numericButtonPublisher.send(buttonTitle)
    }

    @objc private func deleteButtonAction(_ sender: UIButton) {
         deleteButtonPublisher.send(())
    }
}
