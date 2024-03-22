//
//  ButtonEmpty.swift
//  ContentApp
//
//  Created by Никита Китаев on 24.02.2024.
//

import UIKit

final class ButtonEmpty: Button {
    enum Constants {
        static let backgroundColor: UIColor = UIColor.clear
        static let titleColor: UIColor = UIColor.AppColors.accentColor
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
        setTitle(title, for: .normal)
        backgroundColor = Constants.backgroundColor
        setTitleColor(Constants.titleColor, for: .normal)
        titleLabel?.font = UIFont.appFont(.button)
        
        titleEdgeInsets.left = 0
        titleEdgeInsets.right = 0
        titleEdgeInsets.bottom = 0
        titleEdgeInsets.top = 0
    }
}
