//
//  PostInfoViewCell.swift
//  ContentApp
//
//  Created by Никита Китаев on 01.04.2024.
//

import UIKit

class PostTextViewCell: UICollectionViewCell {
    enum Constants {
        static let sidePadding: CGFloat = 16
        static let topPadding: CGFloat = 12
        static let bottomPadding: CGFloat = 16
        static let borderRadius: CGFloat = 16
        
        static let propertyGap: CGFloat = 7
        static let tappedBackgroundColor: UIColor = UIColor.AppColors.cardTappedColor
    }
    
    let textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        configureBackground()
        configureText()
    }
    
    private func configureBackground() {
        backgroundColor = UIColor.AppColors.cardBackgroundColor
    }
    
    private func configureBorders() {
        layer.cornerRadius = Constants.borderRadius
        layer.masksToBounds = true
    }
    
    private func configureText() {
        let textView = UITextView()
        
        textView.frame = CGRect(x: 20, y: 100, width: 300, height: 200)
        
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.lightGray
        textView.textAlignment = .left
        textView.isEditable = true
        textView.isScrollEnabled = true
        
        textView.text = "Начните вводить текст..."
        
        addSubview(textView)
    }
    
    func configure(with post: Post) {
        textView.text = post.content
    }
}

