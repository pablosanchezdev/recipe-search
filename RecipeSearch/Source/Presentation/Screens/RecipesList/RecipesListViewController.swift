//
//  RecipesListViewController.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import UIKit

class RecipesListViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageLabel: UILabel!

    let presenter: RecipesListPresenterProtocol
    var recipes: [RecipeView] = []

    init(presenter: RecipesListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.viewIsReady()
    }

    private func setupViews() {
        setupSearchBar()
        setupCollectionView()
    }

    private func setupSearchBar() {
        searchBar.delegate = self
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout

        let nib = UINib(nibName: RecipeCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: RecipeCell.reuseIdentifier)

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.isHidden = true
    }
}

// MARK: - UICollectionViewDataSource
extension RecipesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.reuseIdentifier, for: indexPath) as? RecipeCell else { return UICollectionViewCell() }

        let recipe = recipes[indexPath.row]
        cell.fill(with: recipe)

        if indexPath.row == recipes.count - 1 {  // Last item
            presenter.didScrollToBottom()
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension RecipesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeSelected = recipes[indexPath.row]
        presenter.didSelect(recipe: recipeSelected)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RecipesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: RecipeCell.height)
    }
}

// MARK: - UISearchBarDelegate
extension RecipesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.queryDidChange(searchText)
    }
}

// MARK: - RecipesListPresenterDelegate
extension RecipesListViewController: RecipesListPresenterDelegate {
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setSearchBarPlaceholder(_ placeholder: String) {
        searchBar.placeholder = placeholder
    }

    func showMessage(_ message: String) {
        collectionView.isHidden = true
        messageLabel.isHidden = false
        messageLabel.text = message
    }

    func renderRecipes(_ recipes: [RecipeView]) {
        self.recipes = recipes
        collectionView.isHidden = false
        messageLabel.isHidden = true
        collectionView.reloadData()
    }

    func appendRecipes(_ recipes: [RecipeView]) {
        self.recipes.append(contentsOf: recipes)
        collectionView.isHidden = false
        messageLabel.isHidden = true
        collectionView.reloadData()
    }
}
