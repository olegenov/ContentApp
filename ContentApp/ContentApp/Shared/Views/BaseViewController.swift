//
//  BaseViewController.swift
//  ContentApp
//
//  Created by Никита Китаев on 25.03.2024.
//

import UIKit

class BaseViewController: UIViewController {
    enum Constants {
        static let navTopOffset: CGFloat = 70
        
        static let nameLabelText: String = "content"
        static let nameLabelTopOffset: CGFloat = 70
        
        static let backgroundColor: UIColor = UIColor.AppColors.backgroundColor
        
        static let errorsGap: CGFloat = 8
        static let errorsBottomGap: CGFloat = 32
        
        static let sideOffset: CGFloat = 16
        
        static let titleTopOffset: CGFloat = 100
    }
    
    internal var errorsStack: UIStackView = UIStackView()
    internal var titleView: PageTitle = PageTitle()
    internal var nav: Nav = Nav()
    internal var onClose: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        configureTemplate()
        configureNav()
        configureUI()
        configureErrors()
        configureHidingKeyBoard()
    }
    
    internal func configureNav() { }
    
    internal func configureUI() { }

    internal func displayNav(topOffset: CGFloat = Constants.navTopOffset) {
        nav.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nav)
        
        NSLayoutConstraint.activate([
            nav.topAnchor.constraint(equalTo: view.topAnchor, constant: topOffset),
            nav.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            nav.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
        ])
    }
    
    private func configureTemplate() {
        view.backgroundColor = Constants.backgroundColor
    }
    
    internal func configureTitle(title: String) {
        titleView = PageTitle(title)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleView)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.titleTopOffset),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
        ])
    }
    
    private func configureErrors() {
        errorsStack.axis = .vertical
        errorsStack.spacing = Constants.errorsGap
        errorsStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(errorsStack)
        
        NSLayoutConstraint.activate([
            errorsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            errorsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
            errorsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.errorsBottomGap),
        ])
    }
    
    internal func displayError(_ error: String) {
        let errorLabel = ErrorLabel(error)
        
        errorLabel.show()
        errorsStack.addArrangedSubview(errorLabel)
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(hideErrorLabel(_:)), userInfo: errorLabel, repeats: false)
    }
    
    private func configureHidingKeyBoard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc private func hideErrorLabel(_ timer: Timer) {
        guard let errorLabel = timer.userInfo as? ErrorLabel else { return }
        errorLabel.removeFromSuperview()
    }
}
