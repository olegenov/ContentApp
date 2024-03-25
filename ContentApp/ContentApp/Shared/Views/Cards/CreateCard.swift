//
//  CreateCard.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

class CreateCard: UICollectionViewCell {
    enum Constants {
        static let sidePadding: CGFloat = 16
        static let topPadding: CGFloat = 12
        static let bottomPadding: CGFloat = 16
        static let borderRadius: CGFloat = 16
        static let borderWidth: CGFloat = 1
        static let tappedBackgroundColor: UIColor = UIColor.AppColors.cardBackgroundColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private var cardTapAction: (() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        configureBorders()
        configureImage()
    }
    
    private func configureBorders() {
        layer.cornerRadius = Constants.borderRadius
        layer.masksToBounds = true
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = UIColor.AppColors.outlineColor.cgColor
    }
    
    private func configureImage() {
        let plusIcon: Icon = IconFactory.createIcon(type: .plus)
        
        addSubview(plusIcon)
        plusIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            plusIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            plusIcon.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configureCardTapAction(_ action: @escaping () -> Void) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
        addGestureRecognizer(tapGesture)
        cardTapAction = action
    }
    
    @objc private func cardTapped() {
        UIView.animate(withDuration: 0.1) {
            self.backgroundColor = Constants.tappedBackgroundColor
        }
        
        self.cardTapAction?()
        
        UIView.animate(withDuration: 0.1) {
            self.backgroundColor = .clear
        }
    }
}

