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
    func open(url: URL)
}

// MARK: - RecipeDetailCoordinatorProtocol
class RecipeDetailCoordinator: RecipeDetailCoordinatorProtocol {
    private let recipe: RecipeView
    private var recipeDetailViewController: RecipeDetailViewController!

    var rootViewController: UIViewController {
        return recipeDetailViewController
    }

    required init(recipe: RecipeView) {
        self.recipe = recipe
    }

    func start() {
        recipeDetailViewController = assembly.recipeDetailViewController()
    }

    func open(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
