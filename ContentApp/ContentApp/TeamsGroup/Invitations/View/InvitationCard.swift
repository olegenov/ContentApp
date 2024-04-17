//
//  InvitationCard.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.04.2024.
//

import UIKit

class InvitationCard: UICollectionViewCell {
    enum Constants {
        static let sidePadding: CGFloat = 16
        static let topPadding: CGFloat = 12
        static let bottomPadding: CGFloat = 16
        static let borderRadius: CGFloat = 16
        
        static let tappedBackgroundColor: UIColor = UIColor.AppColors.cardTappedColor
    }
    
    let titleLabel = UILabel()
    let usernameLabel = UILabel()
    let content = UIStackView()
    let buttons = UIStackView()
    let acceptButton = ButtonFactory.createIconButton(type: .accept)
    let rejectButton = ButtonFactory.createIconButton(type: .reject)
    var acceptAction: (() -> Void)?
    var rejectAction: (() -> Void)?
    
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
        configureContent()
    }
    
    private func configureBackground() {
        backgroundColor = UIColor.AppColors.cardBackgroundColor
    }
    
    private func configureBorders() {
        layer.cornerRadius = Constants.borderRadius
        layer.masksToBounds = true
    }
    
    private func configureContent() {
        content.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.appFont(.cardTitle)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        content.addArrangedSubview(titleLabel)
        
        usernameLabel.font = UIFont.appFont(.cardProperty)
        usernameLabel.textColor = UIColor.AppColors.outlineColor
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        content.addArrangedSubview(usernameLabel)
        
        buttons.addArrangedSubview(acceptButton)
        buttons.addArrangedSubview(rejectButton)
        buttons.translatesAutoresizingMaskIntoConstraints = false
        content.addArrangedSubview(buttons)
        
        content.axis = .horizontal
        content.distribution = .equalSpacing
        addSubview(content)
        
        NSLayoutConstraint.activate([
            content.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sidePadding),
            content.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sidePadding),
            content.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topPadding),
            content.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.bottomPadding),
        ])
    }
    
    func configure(with data: CardData) {
        titleLabel.text = data.title
        usernameLabel.text = data.property[0].1
    }
    
    func configureAcceptAction(_ action: @escaping () -> Void) {
        acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
        acceptAction = action
    }
    
    func configureRejectAction(_ action: @escaping () -> Void) {
        rejectButton.addTarget(self, action: #selector(rejectButtonTapped), for: .touchUpInside)
        rejectAction = action
    }
    
    @objc func acceptButtonTapped() {
        acceptAction?()
    }
    
    @objc func rejectButtonTapped() {
        rejectAction?()
    }
}
