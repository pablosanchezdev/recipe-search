//
//  RecipesListPresenterTests.swift
//  RecipeSearchTests
//
//  Created by Pablo Sanchez Egido on 06/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import XCTest
@testable import RecipeSearch

enum UserQueries: String {
    case fullList = "omelette"
    case emptyList = "omel"
}

class RecipesListPresenterTests: XCTestCase {
    private var viewController: RecipesListViewController!
    private var presenter: RecipesListPresenterProtocol!
    private var coordinator: MockRecipesListCoordinator!

    override func setUp() {
        super.setUp()
        instantiateDependencies()
    }

    override func tearDown() {
        viewController = nil
        presenter = nil
        coordinator = nil
        super.tearDown()
    }
    
    private func instantiateDependencies() {
        let apiClient = MockApiClient()
        let decoder = AppJsonDecoder()
        let repository = MockRemoteRecipeRepository(apiClient: apiClient, decoder: decoder)
        coordinator = MockRecipesListCoordinator()
        presenter = RecipesListPresenter(coordinator: coordinator, repository: repository)
        viewController = RecipesListViewController(presenter: presenter)
        presenter.delegate = viewController
        
        loadViewController()
    }
    
    private func loadViewController() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = viewController
        _ = viewController.view
        
        self.viewController.loadViewIfNeeded()
    }
}

extension RecipesListPresenterTests {
    func testViewIsReady_titleIsCorrect() {
        // Given
        let expectedTitle = LocalizableString.titleLabel.localized()
        
        // When
        presenter.viewIsReady()
        
        // Then
        XCTAssert(viewController.title == expectedTitle, "Wrong title for recipes list view controller")
    }
    
    func testViewIsReady_searchBarPlaceholderIsCorrect() {
        // Given
        let expectedPlaceholder = LocalizableString.searchBarPlaceholder.localized()
        
        // When
        presenter.viewIsReady()
        
        // Then
        XCTAssert(viewController.searchBar.placeholder == expectedPlaceholder, "Wrong placeholder for search bar")
    }
    
    func testViewIsReady_messageLabelIsNotHidden() {
        // Given
        let messageLabelShouldBeHidden = false
        
        // When
        presenter.viewIsReady()
        
        // Then
        XCTAssert(viewController.messageLabel.isHidden == messageLabelShouldBeHidden, "Message label should not be hidden")
    }
    
    func testViewIsReady_collectionViewIsHidden() {
        // Given
        let recipesCollectionViewShouldBeHidden = true
        
        // When
        presenter.viewIsReady()
        
        // Then
        XCTAssert(viewController.collectionView.isHidden == recipesCollectionViewShouldBeHidden, "Collection view should be hidden")
    }
    
    func testQueryFullList_recipesNotEmpty() {
        // Given
        let userQuery = UserQueries.fullList.rawValue
        let expectedRecipesNumber = 10
        
        // When
        presenter.queryDidChange(userQuery)
        
        // Then
        XCTAssertFalse(viewController.recipes.isEmpty, "There should be some recipes")
        XCTAssertTrue(viewController.recipes.count == expectedRecipesNumber, "There should be \(expectedRecipesNumber) recipes")
        XCTAssertTrue(viewController.collectionView.isHidden == false, "Collection view should not be hidden")
    }
    
    func testQueryFullList_pagination_recipesNotEmpty() {
        // Given
        let userQuery = UserQueries.fullList.rawValue
        let expectedRecipesNumber = 20
        
        // When
        presenter.queryDidChange(userQuery)
        presenter.didScrollToBottom()
        
        // Then
        XCTAssertFalse(viewController.recipes.isEmpty, "There should be some recipes")
        XCTAssertTrue(viewController.recipes.count == expectedRecipesNumber, "There should be \(expectedRecipesNumber) recipes")
        XCTAssertTrue(viewController.collectionView.isHidden == false, "Collection view should not be hidden")
    }
    
    func testQueryEmptyList_recipesEmpty() {
        // Given
        let userQuery = UserQueries.emptyList.rawValue
        
        // When
        presenter.queryDidChange(userQuery)
        
        // Then
        XCTAssertTrue(viewController.recipes.isEmpty, "There should be no recipes")
        XCTAssertTrue(viewController.collectionView.isHidden == true, "Collection view should be hidden")
    }
    
    func testRecipeSelected_coordinatorIsCalled() {
        // Given
        let expectedResult = true
        let userQuery = UserQueries.fullList.rawValue
        
        // When
        presenter.queryDidChange(userQuery)
        presenter.didSelect(recipe: viewController.recipes[0])
        
        // Then
        XCTAssertTrue(coordinator.didSelectCalled == expectedResult, "Coordinator should be called")
    }
}
