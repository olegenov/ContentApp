//
//  PageTitle.swift
//  ContentApp
//
//  Created by Никита Китаев on 20.02.2024.
//

import UIKit

final class PageTitle : UIView {
    enum Constants {
        static let titleColor: UIColor = UIColor.AppColors.textColor
        static let titleFontSize: CGFloat = 32
        static let titleBottomOffset: CGFloat = 15
    }
    
    var titleView = UILabel()

    init(_ titleText: String) {
        super.init(frame: .zero)
        
        configureUI(titleText: titleText)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI(titleText: String) {
        let title: UILabel = titleView
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = titleText
        title.font = UIFont.appFont(.title)
        title.textColor = Constants.titleColor
        
        addSubview(title)
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.titleBottomOffset),
        ])
    }
}
