//
//  FormSelectInput.swift
//  ContentApp
//
//  Created by Никита Китаев on 27.03.2024.
//

import UIKit

final class FormSelectInput: UIView, FormInput {
    enum Constants {
        static var height: CGFloat = 36
        static var buttonOffset: CGFloat = 5
        
        static var paddingHorizontal: CGFloat = 16
        static var paddingVertical: CGFloat = 8
        
        static var cornerRadius: CGFloat = 18
        static var borderWidth: CGFloat = 1
        static var borderColor: UIColor = UIColor.AppColors.outlineColor
    }
    
    var stack = UIStackView()
    var input: UIPickerView = UIPickerView()
    var openChoiceButton: Button = ButtonFactory.createIconButton(type: .down)
    var options: [FormSelectInputOption]
    var selectedIndex: Int = 0
    
    var textField: UITextField = UITextField(frame:.zero)
    
    var selectedLabel: UILabel = UILabel()
    var labelContainer: UIView = UIView()
    
    var editField: UITextField = UITextField(frame:.zero)
    
    init(_ options: [FormSelectInputOption]) {
        self.options = options
        
        super.init(frame: .zero)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getData() -> FormSelectInputOption {
        return options[selectedIndex]
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        configureTextField()
        configureInput()
        configureChoiceButton()
        configureLabel()
        configureEditField()
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.height),
        ])
    }
    
    private func configureTextField() {
        textField.inputView = input
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.isHidden = true
        
        addSubview(textField)
    }
    
    private func configureInput() {
        input.delegate = self
        input.dataSource = self
    }
    
    private func configureLabel() {
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        labelContainer.backgroundColor = UIColor.AppColors.cardBackgroundColor
        labelContainer.layer.cornerRadius = Constants.cornerRadius
        
        labelContainer.layoutMargins = UIEdgeInsets(top: Constants.paddingVertical, left: Constants.paddingHorizontal, bottom: Constants.paddingVertical, right: Constants.paddingHorizontal)
        
        selectedLabel.translatesAutoresizingMaskIntoConstraints = false
        selectedLabel.text = options[selectedIndex].name
        selectedLabel.font = UIFont.appFont(.formInput)
        
        if options[selectedIndex].editable {
            labelContainer.isHidden = true
        }
        
        labelContainer.addSubview(selectedLabel)
        
        addSubview(labelContainer)
        
        NSLayoutConstraint.activate([
            labelContainer.heightAnchor.constraint(equalToConstant: Constants.height),
            labelContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelContainer.trailingAnchor.constraint(equalTo: openChoiceButton.leadingAnchor, constant: -Constants.buttonOffset),
            
            selectedLabel.leadingAnchor.constraint(equalTo: labelContainer.layoutMarginsGuide.leadingAnchor),
            selectedLabel.trailingAnchor.constraint(equalTo: labelContainer.layoutMarginsGuide.trailingAnchor),
            selectedLabel.topAnchor.constraint(equalTo: labelContainer.layoutMarginsGuide.topAnchor),
            selectedLabel.bottomAnchor.constraint(equalTo: labelContainer.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    private func configureChoiceButton() {
        openChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        openChoiceButton.addTarget(self, action: #selector(openPickerView), for: .touchUpInside)
        
        addSubview(openChoiceButton)
        
        NSLayoutConstraint.activate([
            openChoiceButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            openChoiceButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func configureEditField() {
        editField.translatesAutoresizingMaskIntoConstraints = false
        editField.delegate = self
        
        editField.text = options[selectedIndex].name
        
        editField.layer.cornerRadius = Constants.cornerRadius
        editField.layer.borderWidth = Constants.borderWidth
        editField.layer.borderColor = Constants.borderColor.cgColor
        
        editField.font = UIFont.appFont(.formInput)
        editField.textColor = UIColor.AppColors.textColor
        
        editField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.paddingHorizontal, height: Constants.height))
        editField.leftViewMode = .always
        
        if !options[selectedIndex].editable {
            editField.isHidden = true
        }
        
        addSubview(editField)
        
        NSLayoutConstraint.activate([
            editField.heightAnchor.constraint(equalToConstant: Constants.height),
            editField.leadingAnchor.constraint(equalTo: leadingAnchor),
            editField.trailingAnchor.constraint(equalTo: openChoiceButton.leadingAnchor, constant: -Constants.buttonOffset),
        ])
    }
    
    @objc private func openPickerView() {
        textField.becomeFirstResponder()
    }
    
    public func updateOptions(newOptions: [FormSelectInputOption]) {
        options += newOptions
    }
}

// MARK: - UIPickerViewDataSource & UIPickerViewDelegate
extension FormSelectInput:  UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
        
        if options[selectedIndex].editable {
            editField.text = options[selectedIndex].name
            editField.isHidden = false
            
            labelContainer.isHidden = true
        } else {
            editField.isHidden = true
            
            selectedLabel.text = options[selectedIndex].name
            labelContainer.isHidden = false
        }
    }
}

// MARK: - UITextFieldDelegate
extension FormSelectInput: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newText = textField.text else {
            selectedLabel.text = options[selectedIndex].name
            input.reloadComponent(0)
            
            return
        }
        
        if newText.isEmpty {
            selectedLabel.text = options[selectedIndex].name
            editField.text = options[selectedIndex].name
            input.reloadComponent(0)
            
            return
        }
        
        if options[selectedIndex].editable {
            options[selectedIndex].name = newText
            selectedLabel.text = newText
            input.reloadComponent(0)
        }
    }
}
