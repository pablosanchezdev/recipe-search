//
//  RecipeDetailCoordinator.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 06/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import UIKit

protocol RecipeDetailCoordinatorProtocol: Coordinable {
    init(recipe: RecipeView)
}

// MARK: - RecipeDetailCoordinatorProtocol
class RecipeDetailCoordinator: RecipeDetailCoordinatorProtocol {
    private let recipeDetailViewController: RecipeDetailViewController

    var rootViewController: UIViewController {
        return recipeDetailViewController
    }

    required init(recipe: RecipeView) {
        let presenter = RecipeDetailPresenter(recipe: recipe)
        recipeDetailViewController = RecipeDetailViewController(presenter: presenter)
        presenter.delegate = recipeDetailViewController
    }
}
