//
//  MenuPosition.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

class MenuPosition: UIView {
    private let textView = UILabel()
    
    init(_ text: String) {
        super.init(frame: .zero)
        
        textView.text = text
        configureUI()
    }
    
    private var positionTapAction: (() -> Void)?
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        isUserInteractionEnabled = true
        textView.font = UIFont.appFont(.title)
        textView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textView)
        
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: textView.bottomAnchor),
            topAnchor.constraint(equalTo: textView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configurePositionTapAction(_ action: @escaping () -> Void) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(positionTapped))
        addGestureRecognizer(tapGesture)
        positionTapAction = action
    }
    
    @objc private func positionTapped() {
        print("tap!")
        UIView.animate(withDuration: 0.1) {
            self.textView.textColor = UIColor.AppColors.outlineColor
        }
        
        self.positionTapAction?()
        
        UIView.animate(withDuration: 0.1) {
            self.textView.textColor = UIColor.black
        }
    }
}
