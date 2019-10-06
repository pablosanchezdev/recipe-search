//
//  RecipesListCoordinator.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 06/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import UIKit

protocol RecipesListCoordinatorProtocol: Coordinable {
    func didSelect(recipe: RecipeView)
}

class RecipesListCoordinator: RecipesListCoordinatorProtocol {
    private var navController: UINavigationController!

    var rootViewController: UIViewController {
        return navController
    }

    func start() {
        let viewController = assembly.recipesListViewController()
        navController = UINavigationController(rootViewController: viewController)
    }

    func didSelect(recipe: RecipeView) {
        let recipeDetailCoordinator = assembly.recipeDetailCoordinator(recipe: recipe)
        navController.pushViewController(recipeDetailCoordinator.rootViewController, animated: true)
    }
}
