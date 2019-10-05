//
//  LocalizableString.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import Foundation

enum LocalizableString: String {
    case titleLabel = "title_label"
    case searchBarPlaceholder = "search_bar_placeholder"
    case errorLoadingImage = "error_loading_recipe_image"
}

extension LocalizableString {
    func localized() -> String {
        return NSLocalizedString(rawValue, comment: "")
    }
}
