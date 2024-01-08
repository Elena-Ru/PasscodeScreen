//
//  RootView.swift
//  PasscodeView
//
//  Created by Елена Русских on 2023-08-30.
//

import UIKit
import SnapKit
import Combine

// MARK: - RootView
final class RootView: UIView {
  
    // MARK: Properties
    let numericButtonPublisher = PassthroughSubject<String, Never>()
    let deleteButtonPublisher = PassthroughSubject<Void, Never>()
    let centralNumericTitles = Constants.centralNumericTitles
    let leftNumericTitles = Constants.leftNumericTitles
    let rightNumericTitles = Constants.rightNumericTitles
    var circles: [UIView] = []
    var numericButtons: [UIButton] = []
    
    // MARK: Views
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
        stack.spacing = Constants.circleSize
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
    
    // MARK: Initializer
    init() {
        super.init(frame: CGRect())
        createCircles(count: Constants.passcodeDigitCount)
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
              make.width.height.equalTo(Constants.circleSize)
            }
            circle.makeRounded(borderColor: .lightGrayBorder, borderWidth: Constants.borderWidth)
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
                 make.width.height.equalTo(Constants.numericButtonSize)
             }
         }
     }
  
    private func setupLayout() {
        [
            enterPasswordLabel,
            stackView,
            numericCentralStackView,
            numericLeftStackView,
            numericRightStackView,
            deleteButton
        ].forEach { addSubview($0) }
      
        enterPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(Constants.enterPasswordLabelTopOffset)
            make.centerX.equalTo(self)
        }
        
        stackView.snp.makeConstraints { make in
            make.width.equalTo(Constants.stackViewWidth)
            make.height.equalTo(Constants.circleSize)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(Constants.stackViewTopOffset)
            make.centerX.equalTo(self)
        }
      
        numericCentralStackView.snp.makeConstraints { make in
            make.width.equalTo(Constants.numericButtonSize)
            make.height.equalTo(Constants.extendedVStackHeight)
            make.top.equalTo(stackView.snp.bottom).offset(Constants.topOffset)
            make.centerX.equalTo(self)
        }
      
        numericLeftStackView.snp.makeConstraints { make in
            make.width.equalTo(Constants.numericButtonSize)
            make.height.equalTo(Constants.regularVStackHeight)
            make.top.equalTo(stackView.snp.bottom).offset(Constants.topOffset)
            make.centerX.equalTo(numericCentralStackView.snp.leading).offset(-Constants.numericButtonSize)
        }
      
        numericRightStackView.snp.makeConstraints { make in
            make.width.equalTo(Constants.numericButtonSize)
            make.height.equalTo(Constants.regularVStackHeight)
            make.top.equalTo(stackView.snp.bottom).offset(Constants.topOffset)
            make.centerX.equalTo(numericCentralStackView.snp.trailing).offset(Constants.numericButtonSize)
        }
      
        deleteButton.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.numericButtonSize)
            make.top.equalTo(numericRightStackView.snp.bottom).offset(Constants.deleteBtntopOffset)
            make.centerX.equalTo(numericCentralStackView.snp.trailing).offset(Constants.numericButtonSize)
        }
    }
  
    // MARK: - Objc methods
    @objc 
    private func numericButtonTapped(_ sender: UIButton) {
         guard let buttonTitle = sender.titleLabel?.text else { return }
         numericButtonPublisher.send(buttonTitle)
    }

    @objc 
    private func deleteButtonAction(_ sender: UIButton) {
         deleteButtonPublisher.send(())
    }
}

// MARK: - Constants
private extension RootView {
    enum Constants {
        static let circleSize: CGFloat = 20
        static let numericButtonSize: CGFloat = 60
        static let passcodeDigitCount: Int = 4
        static let regularVStackHeight: CGFloat = 210
        static let extendedVStackHeight: CGFloat = 290
        static let topOffset: CGFloat = 250
        static let deleteBtntopOffset: CGFloat = 20
        static let stackViewTopOffset: CGFloat = 100
        static let stackViewWidth: CGFloat = 180
        static let enterPasswordLabelTopOffset: CGFloat = 30
        static let borderWidth: CGFloat = 2
        static let centralNumericTitles: [String] = ["2", "5", "8", "0"]
        static let leftNumericTitles: [String] = ["1", "4", "7"]
        static let rightNumericTitles: [String] = ["3", "6", "9"]
    }
}
