//
//  FormInput.swift
//  ContentApp
//
//  Created by Никита Китаев on 20.02.2024.
//

import UIKit

protocol FormInput: UIView {
    associatedtype DataType
    func getData() -> DataType;
}
