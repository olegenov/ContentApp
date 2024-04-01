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
        
        static let propertyGap: CGFloat = 7
        static let tappedBackgroundColor: UIColor = UIColor.AppColors.cardTappedColor
    }
    
    private var cardTapAction: (() -> Void)?
    
    let titleLabel = UILabel()
    let properties = UIStackView()
    
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
        configureProperties()
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
        ])
    }
    
    private func configureProperties() {
        properties.translatesAutoresizingMaskIntoConstraints = false
        properties.axis = .vertical
        properties.spacing = Constants.propertyGap
        properties.distribution = .fillProportionally
        
        addSubview(properties)
        
        NSLayoutConstraint.activate([
            properties.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sidePadding),
            properties.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sidePadding),
            properties.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.propertyGap),
        ])
    }
    
    private func addProperty(data: (Icon, String)) {
        let propertyStack: UIStackView = UIStackView()
        
        let icon = data.0
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = data.1
        label.font = UIFont.appFont(.cardProperty)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        propertyStack.addArrangedSubview(icon)
        propertyStack.addArrangedSubview(label)
        
        propertyStack.axis = .horizontal
        propertyStack.spacing = Constants.propertyGap
        propertyStack.distribution = .fillProportionally
        
        properties.addArrangedSubview(propertyStack)
    }
    
    func configure(with data: CardData) {
        properties.clear()
        
        titleLabel.text = data.title
        
        
        for item in data.property {
            addProperty(data: item)
        }
    }
    
    func configureCardTapAction(_ action: @escaping () -> Void) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
        addGestureRecognizer(tapGesture)
        cardTapAction = action
    }
    
    @objc private func cardTapped() {
        self.cardTapAction?()
    }
}
