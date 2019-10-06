//
//  RecipesListViewController.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import UIKit

class RecipesListViewController: UIViewController {
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var messageLabel: UILabel!

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
        setupErrorLabel()
        setupCollectionView()
    }

    private func setupSearchBar() {
        searchBar.delegate = self
    }

    private func setupErrorLabel() {
        messageLabel.isHidden = false
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

        return cell
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
        titleLabel.text = title
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
}
