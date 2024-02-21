//
//  Form.swift
//  ContentApp
//
//  Created by Никита Китаев on 20.02.2024.
//

import UIKit

final class Form: UIView {
    enum Constants {
        static let defaultSubmitText: String = "Submit"
        static let minFormHeight: CGFloat = 300
        static let formGap: CGFloat = 14
    }
    
    private var contents: UIStackView = UIStackView()
    private var fields: [FormInput] = [FormInput]()
    private var submitButtonAction: (() -> Void)?
    private var submitButton: UIButton = UIButton()
    
    private var formTitle: UIView = UIView()
    
    init(_ title: String, formFields: [FormInput], submitText: String = Constants.defaultSubmitText) {
        super.init(frame: .zero)
        
        fields = formFields
        configureUI(title: title, submitText: submitText)
    }
    
    init(_ title: String, submitText: String = Constants.defaultSubmitText) {
        super.init(frame: .zero)
        
        configureUI(title: title, submitText: submitText)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addInputField(_ field: FormInput) {
        fields.append(field)
    }
    
    private func configureUI(title: String, submitText: String) {
        configureFormTitle(title: title)
        configureFormFields()
        configureSubmitButton(title: submitText)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.minFormHeight),
        ])
    }
    
    private func configureFormTitle(title: String) {
        formTitle = PageTitle(title)
        addSubview(formTitle)
        formTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            formTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }

    private func configureFormFields() {
        for field in fields {
            contents.addArrangedSubview(field)
        }
        
        contents.axis = .vertical
        contents.spacing = Constants.formGap
        contents.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contents)
        
        NSLayoutConstraint.activate([
            contents.leadingAnchor.constraint(equalTo: leadingAnchor),
            contents.trailingAnchor.constraint(equalTo: trailingAnchor),
            contents.topAnchor.constraint(equalTo: formTitle.bottomAnchor),
        ])

    }
    
    private func configureSubmitButton(title: String) {
        submitButton = ButtonFactory.createButton(type: .active, title: title)
        
        self.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: contents.bottomAnchor, constant: Constants.formGap),
            submitButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    public func setSubmitButtonText(_ text: String) {
        submitButton.setTitle(text, for: .normal)
    }
    
    func configureSubmitButtonAction(_ action: @escaping () -> Void) {
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        submitButtonAction = action
    }

    @objc private func submitButtonTapped() {
        submitButtonAction?()
    }
}
