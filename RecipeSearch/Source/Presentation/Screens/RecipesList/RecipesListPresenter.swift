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
    func didScrollToBottom()
    func didSelect(recipe: RecipeView)
}

protocol RecipesListPresenterDelegate: class {
    func setTitle(_ title: String)
    func setSearchBarPlaceholder(_ placeholder: String)
    func showMessage(_ message: String)
    func renderRecipes(_ recipes: [RecipeView])
    func appendRecipes(_ recipes: [RecipeView])
}

class RecipesListPresenter {
    weak var delegate: RecipesListPresenterDelegate?

    private var page = 1
    private var currentQuery = ""

    private let coordinator: RecipesListCoordinatorProtocol
    private let repository: RecipeRepository

    init(coordinator: RecipesListCoordinatorProtocol, repository: RecipeRepository) {
        self.coordinator = coordinator
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

        page = 1
        currentQuery = query
        repository.searchRecipes(for: .by(name: query, page: page)) { [unowned self] (recipes, error) in
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

    func didScrollToBottom() {
        page += 1
        repository.searchRecipes(for: .by(name: currentQuery, page: page)) { [unowned self] (recipes, error) in
            if let error = error {
                self.delegate?.showMessage(error.localizedDescription)
            }

            if let recipes = recipes {
                if recipes.count > 0 {
                    let recipesView = recipes.map { RecipeViewMapper.recipeToRecipeView($0) }
                    self.delegate?.appendRecipes(recipesView)
                }
            }
        }
    }

    func didSelect(recipe: RecipeView) {
        coordinator.didSelect(recipe: recipe)
    }
}
