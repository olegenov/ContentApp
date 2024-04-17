//
//  InvitationCard.swift
//  ContentApp
//
//  Created by Никита Китаев on 31.03.2024.
//

import UIKit

class MyInvitationsCard: UICollectionViewCell {
    enum Constants {
        static let sidePadding: CGFloat = 16
        static let topPadding: CGFloat = 12
        static let bottomPadding: CGFloat = 16
        static let borderRadius: CGFloat = 16
        static let borderWidth: CGFloat = 1
        static let tappedBackgroundColor: UIColor = UIColor.AppColors.cardBackgroundColor
        static let title: String = "invitations"
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
        headerStack.axis = .horizontal
        headerStack.spacing = 10
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = Constants.title
        titleLabel.font = UIFont.appFont(.cardTitle)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerStack.addArrangedSubview(titleLabel)
        
        amount.clipsToBounds = true
        amount.font = UIFont.appFont(.buttonActive)
        amount.textColor = UIColor.AppColors.white
        amount.backgroundColor = UIColor.AppColors.accentColor
        amount.textAlignment = .center
        amount.translatesAutoresizingMaskIntoConstraints = false
        amount.layer.cornerRadius = 12
        headerStack.addArrangedSubview(amount)
        
        addSubview(headerStack)
        
        NSLayoutConstraint.activate([
            headerStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            amount.widthAnchor.constraint(equalToConstant: 24),
            amount.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    func configureAmountText(_ amountNum: String) {
        amount.text = amountNum
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
