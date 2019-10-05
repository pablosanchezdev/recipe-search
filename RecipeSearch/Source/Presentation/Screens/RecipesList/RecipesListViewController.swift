//
//  RecipesListViewController.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import UIKit

class RecipesListViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    let presenter: RecipesListPresenterProtocol
    var recipes: [Recipe] = []

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
    }

    private func setupViews() {
        setupTitleLabel()
        setupSearchBar()
        setupCollectionView()
    }

    private func setupTitleLabel() {
        titleLabel.text = LocalizableString.titleLabel.localized()
    }

    private func setupSearchBar() {
        searchBar.placeholder = LocalizableString.searchBarPlaceholder.localized()
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
    func renderRecipes(_ recipes: [Recipe]) {
        self.recipes = recipes
        collectionView.reloadData()
    }

    func showError(_ error: String) {

    }
}
