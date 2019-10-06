//
//  Swinject.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 06/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import UIKit
import Swinject

let assembly = SwinjectAssembly()

class SwinjectAssembly {
    private let container = Container()
    private var recipeSelected: RecipeView!

    fileprivate init() {
        registerDependencies()
    }

    private func registerDependencies() {
        registerDataLayerDependencies()
        registerPresentationLayerDependencies()
    }

    private func registerDataLayerDependencies() {
        container.register(AppDecoder.self) { _ in AppJsonDecoder() }
        container.register(ApiClient.self) { _ in AlamofireApiClient() }
        container.register(RecipeRepository.self) { r in
            let apiClient = r.resolve(ApiClient.self)!
            let decoder = r.resolve(AppDecoder.self)!
            return RemoteRecipeRepository(apiClient: apiClient, decoder: decoder)
        }
    }

    private func registerPresentationLayerDependencies() {
        registerRecipesListDependencies()
        registerRecipeDetailDependencies()
    }

    private func registerRecipesListDependencies() {
        container
            .register(RecipesListCoordinatorProtocol.self) { _ in RecipesListCoordinator() }
            .initCompleted { (_, c) in c.start() }
        container
            .register(RecipesListPresenterProtocol.self) { r in
                let coordinator = r.resolve(RecipesListCoordinatorProtocol.self)!
                let repository = r.resolve(RecipeRepository.self)!
                return RecipesListPresenter(coordinator: coordinator, repository: repository)
            }
            .initCompleted { (r, c) in
                let presenter = c as! RecipesListPresenter
                presenter.delegate = r.resolve(RecipesListViewController.self)
            }
        container.register(RecipesListViewController.self) { r in
            let presenter = r.resolve(RecipesListPresenterProtocol.self)!
            return RecipesListViewController(presenter: presenter)
        }
    }

    private func registerRecipeDetailDependencies() {
        container
            .register(RecipeDetailCoordinatorProtocol.self) { [unowned self] _ in RecipeDetailCoordinator(recipe: self.recipeSelected) }
            .initCompleted { (_, c) in c.start() }
        container
            .register(RecipeDetailPresenterProtocol.self) { [unowned self] r in
                let coordinator = r.resolve(RecipeDetailCoordinatorProtocol.self)!
                return RecipeDetailPresenter(coordinator: coordinator, recipe: self.recipeSelected)
            }
            .initCompleted { (r, c) in
                let presenter = c as! RecipeDetailPresenter
                presenter.delegate = r.resolve(RecipeDetailViewController.self)
            }
        container.register(RecipeDetailViewController.self) { r in
            let presenter = r.resolve(RecipeDetailPresenterProtocol.self)!
            return RecipeDetailViewController(presenter: presenter)
        }
    }
}

// MARK: - Assembly
extension SwinjectAssembly: Assembly {
    func recipesListViewController() -> RecipesListViewController {
        return container.resolve(RecipesListViewController.self)!
    }
    
    func recipesListCoordinator() -> Coordinable {
        return container.resolve(RecipesListCoordinatorProtocol.self)!
    }

    func recipeDetailViewController() -> RecipeDetailViewController {
        return container.resolve(RecipeDetailViewController.self)!
    }

    func recipeDetailCoordinator(recipe: RecipeView) -> Coordinable {
        recipeSelected = recipe
        return container.resolve(RecipeDetailCoordinatorProtocol.self)!
    }
}
