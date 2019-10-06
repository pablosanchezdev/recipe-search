//
//  RecipeApiMapper.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import Foundation

extension RecipeAPI {
    func toRecipe() -> Recipe {
        let ingredientsArray = ingredients.components(separatedBy: ",")
        return Recipe(thumbnailUrl: thumbnail, title: title, ingredients: ingredientsArray, webUrl: href)
    }
}
