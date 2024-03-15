//
//  UIViewControllerExtension.swift
//  ContentApp
//
//  Created by Никита Китаев on 20.02.2024.
//

import UIKit

extension UIViewController {
    enum Constants {
        static let BoldTextFont: String = "Nunito-Bold"
        
        static let NameLabelText: String = "content"
        static let NameLabelColor: UIColor = UIColor.AppColors.textColor
        static let NameLabelFontSize: CGFloat = 24
        static let NameLabelTopOffset: CGFloat = 70
        
        static let BackgroundColor: UIColor = UIColor.AppColors.backgroundColor
    }
    
    public func configureNameLabel() {
        let nameLabel = UILabel()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = Constants.NameLabelText
        
        nameLabel.font = UIFont.appFont(.nameLabel)
        
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.NameLabelTopOffset)
        ])
    }
    
    public func configureTemplate() {
        view.backgroundColor = Constants.BackgroundColor
    }
}
