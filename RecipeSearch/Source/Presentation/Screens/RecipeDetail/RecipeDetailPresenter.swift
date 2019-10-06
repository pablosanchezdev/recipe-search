//
//  RecipeDetailPresenter.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 06/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import Foundation

protocol RecipeDetailPresenterProtocol {
    var delegate: RecipeDetailPresenterDelegate? { get set }
    func viewIsReady()
    func didTapWebButton()
}

protocol RecipeDetailPresenterDelegate: class {
    func setWebButtonTitle(_ title: String)
    func renderRecipeImage(_ imageUrl: String)
    func renderRecipeTitle(_ title: String)
    func renderRecipeIngredients(_ ingredients: [String])
}

class RecipeDetailPresenter {
    weak var delegate: RecipeDetailPresenterDelegate?

    private let coordinator: RecipeDetailCoordinatorProtocol
    private let recipe: RecipeView

    init(coordinator: RecipeDetailCoordinatorProtocol, recipe: RecipeView) {
        self.coordinator = coordinator
        self.recipe = recipe
    }
}

// MARK: - RecipeDetailPresenterProtocol
extension RecipeDetailPresenter: RecipeDetailPresenterProtocol {
    func viewIsReady() {
        delegate?.setWebButtonTitle(LocalizableString.webButtonTitle.localized())
        delegate?.renderRecipeImage(recipe.thumbnailUrl)
        delegate?.renderRecipeTitle(recipe.title)
        delegate?.renderRecipeIngredients(recipe.ingredients)
    }

    func didTapWebButton() {
        guard let url = URL(string: recipe.webUrl) else { return }

        coordinator.open(url: url)
    }
}
