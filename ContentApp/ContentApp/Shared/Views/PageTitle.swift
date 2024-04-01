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
        static let titleHeight: CGFloat = 44
    }
    
    var titleView = UILabel()

    init(_ titleText: String) {
        super.init(frame: .zero)
        
        configureUI(titleText: titleText)
    }
    
    init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI(titleText: String) {
        translatesAutoresizingMaskIntoConstraints = false
        
        configureTitle(titleText: titleText)
        
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constants.titleBottomOffset),
            centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        ])
    }
    
    private func configureTitle(titleText: String) {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = titleText
        titleView.font = UIFont.appFont(.title)
        titleView.textColor = Constants.titleColor
        
        addSubview(titleView)
        
        NSLayoutConstraint.activate([
            titleView.heightAnchor.constraint(equalToConstant: Constants.titleHeight),
        ])
    }
    
    public func centerSelf() {
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
