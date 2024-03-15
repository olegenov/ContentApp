//
//  Card.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

class Card: UICollectionViewCell {
    enum Constants {
        static let sidePadding: CGFloat = 16
        static let topPadding: CGFloat = 12
        static let bottomPadding: CGFloat = 16
        static let borderRadius: CGFloat = 16
    }
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        configureBackground()
        configureBorders()
        configureTitle()
    }
    
    private func configureBackground() {
        backgroundColor = UIColor.AppColors.cardBackgroundColor
    }
    
    private func configureBorders() {
        layer.cornerRadius = Constants.borderRadius
        layer.masksToBounds = true
    }
    
    private func configureTitle() {
        titleLabel.font = UIFont.appFont(.cardTitle)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sidePadding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sidePadding),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topPadding),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.bottomPadding)
        ])
    }
    
    func configure(with data: CardData) {
        titleLabel.text = data.title
    }
}
