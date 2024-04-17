//
//  PostInfoViewCell.swift
//  ContentApp
//
//  Created by Никита Китаев on 01.04.2024.
//

import UIKit

class PostInfoSection: UIView {
    enum Constants {
        static let sidePadding: CGFloat = 16
        static let topPadding: CGFloat = 12
        static let bottomPadding: CGFloat = 16
        static let borderRadius: CGFloat = 16
        
        static let propertyGap: CGFloat = 14
        static let iconGap: CGFloat = 10
        static let tappedBackgroundColor: UIColor = UIColor.AppColors.cardTappedColor
    }
    
    let infoStack: UIStackView = UIStackView()
    
    var assignLabel: UILabel = UILabel()
    var publishLabel: UILabel = UILabel()
    var deadlineLabel: UILabel = UILabel()
    
    var assignLabelAction: (() -> Void)?
    var publishLabelAction: (() -> Void)?
    var deadlineLabelAction: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        configureInfoStack()
        configurePropertyActions()
    }
    
    private func configureInfoStack() {
        infoStack.axis = .vertical
        infoStack.spacing = Constants.propertyGap
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        
        assignLabel = addProperty(property: (IconFactory.createIcon(type: .assign, big: true), "assign"))
        publishLabel = addProperty(property: (IconFactory.createIcon(type: .calendar, big: true), "publish date"))
        deadlineLabel = addProperty(property: (IconFactory.createIcon(type: .deadline, big: true), "deadline date"))
        
        addSubview(infoStack)
        
        NSLayoutConstraint.activate([
            infoStack.topAnchor.constraint(equalTo: topAnchor),
            infoStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoStack.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func addProperty(property: (Icon, String)) -> UILabel {
        let propertyStack = UIStackView()
        propertyStack.axis = .horizontal
        propertyStack.spacing = Constants.iconGap
        
        property.0.translatesAutoresizingMaskIntoConstraints = false
        propertyStack.addArrangedSubview(property.0)
        
        let propertyText = UILabel()
        propertyText.text = property.1
        propertyText.font = UIFont.appFont(.regular)
        propertyText.translatesAutoresizingMaskIntoConstraints = false
        propertyStack.addArrangedSubview(propertyText)
        
        infoStack.addArrangedSubview(propertyStack)
        
        return propertyText
    }
    
    private func configurePropertyActions() {
        assignLabel.isUserInteractionEnabled = true
        let assignTapGesture = UITapGestureRecognizer(target: self, action: #selector(assignLabelTapped))
        assignLabel.addGestureRecognizer(assignTapGesture)
        
        publishLabel.isUserInteractionEnabled = true
        let publishTapGesture = UITapGestureRecognizer(target: self, action: #selector(publishLabelTapped))
        publishLabel.addGestureRecognizer(publishTapGesture)
        
        deadlineLabel.isUserInteractionEnabled = true
        let deadlineTapGesture = UITapGestureRecognizer(target: self, action: #selector(deadlineLabelTapped))
        deadlineLabel.addGestureRecognizer(deadlineTapGesture)
    }
    
    @objc func assignLabelTapped() {
        assignLabelAction?()
    }
    
    @objc func publishLabelTapped() {
        publishLabelAction?()
    }
    
    @objc func deadlineLabelTapped() {
        deadlineLabelAction?()
    }
    
    func configureAssignLabelAction(action: @escaping () -> Void) {
        assignLabelAction = action
    }
    
    func configurePublishLabelAction(action: @escaping () -> Void) {
        publishLabelAction = action
    }
    
    func configureDeadlineLabelAction(action: @escaping () -> Void) {
        deadlineLabelAction = action
    }
    
    func configure(with post: PostInfo) {
        assignLabel.text = post.assign
        publishLabel.text = post.publishing.toString()
        deadlineLabel.text = post.deadline.toString()
    }
}


