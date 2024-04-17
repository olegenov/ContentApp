//
//  NewInvitationCard.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.04.2024.
//

import UIKit

class NewInvitationCard: UICollectionViewCell {
    enum Constants {
        static let sidePadding: CGFloat = 16
        static let topPadding: CGFloat = 12
        static let bottomPadding: CGFloat = 16
        static let borderRadius: CGFloat = 16
        static let borderWidth: CGFloat = 1
        static let tappedBackgroundColor: UIColor = UIColor.AppColors.cardBackgroundColor
        static let title: String = "invite"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private var cardTapAction: (() -> Void)?
    private var titleLabel: UILabel = UILabel()
    private var amount: UILabel = UILabel()
    private var headerStack = UIStackView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        configureBorders()
        configureHeader()
    }
    
    private func configureBorders() {
        layer.cornerRadius = Constants.borderRadius
        layer.masksToBounds = true
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = UIColor.AppColors.outlineColor.cgColor
    }
    
    private func configureHeader() {
        titleLabel.text = Constants.title
        titleLabel.font = UIFont.appFont(.cardTitle)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sidePadding),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
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

