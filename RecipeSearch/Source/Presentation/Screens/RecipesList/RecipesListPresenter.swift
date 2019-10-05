//
//  RecipesListPresenter.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import Foundation

protocol RecipesListPresenterProtocol {
    var delegate: RecipesListPresenterDelegate? { get set }
    func queryDidChange(_ query: String)
}

protocol RecipesListPresenterDelegate: class {
    func renderRecipes(_ recipes: [Recipe])
    func showError(_ error: String)
}

class RecipesListPresenter: RecipesListPresenterProtocol {
    weak var delegate: RecipesListPresenterDelegate?

    let repository: RecipeRepository

    init(repository: RecipeRepository) {
        self.repository = repository
    }

    func queryDidChange(_ query: String) {
        repository.searchRecipes(for: .by(name: query)) { [unowned self] (recipes, error) in
            if let error = error {
                self.delegate?.showError(error.localizedDescription)
            }

            if let recipes = recipes {
                self.delegate?.renderRecipes(recipes)
            }
        }
    }
}
