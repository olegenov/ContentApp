//
//  PostInfoViewCell.swift
//  ContentApp
//
//  Created by Никита Китаев on 01.04.2024.
//

import UIKit

class PostTextSection: UIView {
    enum Constants {
        static let sidePadding: CGFloat = 16
        static let topPadding: CGFloat = 12
        static let bottomPadding: CGFloat = 16
        static let borderRadius: CGFloat = 16
        
        static let propertyGap: CGFloat = 7
        static let tappedBackgroundColor: UIColor = UIColor.AppColors.cardTappedColor
    }
    
    let textView = UITextView()
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        configureTextField()
    }
    
    private func configureTextField() {
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor.black
        textView.textAlignment = .left
        textView.isEditable = true
        textView.isScrollEnabled = true
        
        textView.text = "hello world!"
        textView.font = UIFont.appFont(.formInput)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func configure(with post: PostInfo) {
        if post.content.isEmpty {
            return
        }
        
        textView.text = post.content
    }
}
