//
//  ActiveButton.swift
//  ContentApp
//
//  Created by Никита Китаев on 20.02.2024.
//

import UIKit

final class ButtonActive: Button {
    enum Constants {
        static let backgroundColor: UIColor = UIColor.AppColors.accentColor
        static let tappedBackgroundColor: UIColor = UIColor.AppColors.lightAccentColor
        static let titleColor: UIColor = UIColor.AppColors.white
    }

    override init(_ title: String) {
        super.init(title)
        
        configureUI(title)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI(_ title: String) {
        backgroundColor = Constants.backgroundColor
        setTitleColor(Constants.titleColor, for: .normal)
        titleLabel?.font = UIFont.appFont(.buttonActive)
        
        addPadding()
    }
    
    @objc override func buttonTouchDown() {
        UIView.animate(withDuration: 0.1) {
            self.backgroundColor = Constants.tappedBackgroundColor
        }
    }

    @objc override func buttonTouchUp() {
        UIView.animate(withDuration: 0.1) {
            self.backgroundColor = Constants.backgroundColor
        }
    }
}

