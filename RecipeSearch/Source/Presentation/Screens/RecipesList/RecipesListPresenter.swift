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
    func viewIsReady()
    func queryDidChange(_ query: String)
}

protocol RecipesListPresenterDelegate: class {
    func setTitle(_ title: String)
    func setSearchBarPlaceholder(_ placeholder: String)
    func showMessage(_ message: String)
    func renderRecipes(_ recipes: [RecipeView])
}

class RecipesListPresenter {
    weak var delegate: RecipesListPresenterDelegate?

    private let repository: RecipeRepository

    init(repository: RecipeRepository) {
        self.repository = repository
    }
}

extension RecipesListPresenter: RecipesListPresenterProtocol {
    func viewIsReady() {
        delegate?.setTitle(LocalizableString.titleLabel.localized())
        delegate?.setSearchBarPlaceholder(LocalizableString.searchBarPlaceholder.localized())
        delegate?.showMessage(LocalizableString.noRecipes.localized())
    }

    func queryDidChange(_ query: String) {
        guard !query.isEmpty else {
            self.delegate?.showMessage(LocalizableString.noRecipes.localized())
            return
        }

        repository.searchRecipes(for: .by(name: query)) { [unowned self] (recipes, error) in
            if let error = error {
                self.delegate?.showMessage(error.localizedDescription)
            }

            if let recipes = recipes {
                if recipes.count > 0 {
                    let recipesView = recipes.map { RecipeViewMapper.recipeToRecipeView($0) }
                    self.delegate?.renderRecipes(recipesView)
                } else {
                    self.delegate?.showMessage(LocalizableString.noRecipes.localized())
                }
            }
        }
    }
}
