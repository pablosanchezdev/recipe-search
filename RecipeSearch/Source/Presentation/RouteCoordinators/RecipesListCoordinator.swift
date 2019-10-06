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

class RecipesListCoordinator {
    private var navController: UINavigationController!

    init() {
        let decoder = AppJsonDecoder()
        let client = AlamofireApiClient()
        let repo = RemoteRecipeRepository(apiClient: client, decoder: decoder)
        let presenter = RecipesListPresenter(coordinator: self, repository: repo)
        let viewController = RecipesListViewController(presenter: presenter)
        presenter.delegate = viewController

        navController = UINavigationController(rootViewController: viewController)
    }
}

// MARK: - RecipesListCoordinatorProtocol
extension RecipesListCoordinator: RecipesListCoordinatorProtocol {
    var rootViewController: UIViewController {
        return navController
    }

    func didSelect(recipe: RecipeView) {
        let recipeDetailCoordinator: RecipeDetailCoordinatorProtocol = RecipeDetailCoordinator(recipe: recipe)
        navController.pushViewController(recipeDetailCoordinator.rootViewController, animated: true)
    }
}
