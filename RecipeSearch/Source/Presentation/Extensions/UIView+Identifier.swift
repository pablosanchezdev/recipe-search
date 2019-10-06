//
//  UIView+Identifier.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import UIKit

protocol ReuseIdentifier {
    static var reuseIdentifier: String { get }
}

/// Ads to any view an identifier which consists of its name
extension ReuseIdentifier where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: ReuseIdentifier { }
