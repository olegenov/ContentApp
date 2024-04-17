//
//  MenuPosition.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.03.2024.
//

import UIKit

class MenuPosition: UIButton {
    init(_ text: String) {
        super.init(frame: .zero)
        
        setTitle(text, for: .normal)
        configureUI()
    }
    
    private var positionTapAction: (() -> Void)?
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.appFont(.title)
        setTitleColor(UIColor.AppColors.textColor, for: .normal)
    }
    
    func configurePositionTapAction(_ action: @escaping () -> Void) {
        self.addTarget(self, action: #selector(positionTapped), for: .touchUpInside)
        positionTapAction = action
    }
    
    @objc private func positionTapped() {
        positionTapAction?()
    }
}
