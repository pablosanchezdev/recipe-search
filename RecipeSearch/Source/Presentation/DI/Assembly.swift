//
//  Assembly.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 06/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import UIKit

protocol Assembly {
    func recipesListViewController() -> RecipesListViewController
    func recipesListCoordinator() -> Coordinable

    func recipeDetailViewController() -> RecipeDetailViewController
    func recipeDetailCoordinator(recipe: RecipeView) -> Coordinable
}
