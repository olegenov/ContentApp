//
//  UIStackViewExtension.swift
//  ContentApp
//
//  Created by Никита Китаев on 24.02.2024.
//

import UIKit

extension UIStackView {
    public func clear() {
        arrangedSubviews.forEach {
            $0.removeFromSuperview()
            removeArrangedSubview($0)
        }
    }
}
