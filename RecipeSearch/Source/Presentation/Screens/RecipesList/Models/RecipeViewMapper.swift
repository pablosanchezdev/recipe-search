//
//  RecipeViewMapper.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 06/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import Foundation

struct RecipeViewMapper {
    static func recipeToRecipeView(_ recipe: Recipe) -> RecipeView {
        return RecipeView(thumbnailUrl: recipe.thumbnailUrl, title: recipe.title, ingredients: recipe.ingredients)
    }
}
