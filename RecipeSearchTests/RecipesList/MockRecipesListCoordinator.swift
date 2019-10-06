//
//  MockRecipesListCoordinator.swift
//  RecipeSearchTests
//
//  Created by Pablo Sanchez on 07/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import UIKit
@testable import RecipeSearch

class MockRecipesListCoordinator: RecipesListCoordinatorProtocol {
    var rootViewController: UIViewController {
        return UIViewController()
    }
    
    func start() {
        
    }
    
    var didSelectCalled = false
    func didSelect(recipe: RecipeView) {
        didSelectCalled = true
    }
}
