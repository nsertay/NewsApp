//
//  Extensions.swift
//  NewsApp
//
//  Created by Nurmukhanbet Sertay on 06.05.2024.
//

import Foundation
import UIKit

extension UIStackView {
    func applyShadowStackView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 0.8)
        layer.shadowRadius = 2
        clipsToBounds = false
    }
}
