//
//  RecipeDetailViewController.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 06/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var webButton: UIButton!

    let presenter: RecipeDetailPresenterProtocol

    init(presenter: RecipeDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func didTapWebButton() {
        presenter.didTapWebButton()
    }
}

// MARK: - RecipesListPresenterDelegate
extension RecipeDetailViewController: RecipeDetailPresenterDelegate {
    func setWebButtonTitle(_ title: String) {
        webButton.setTitle(title, for: .normal)
    }

    func renderRecipeImage(_ imageUrl: String) {
        guard let url = URL(string: imageUrl) else {
            let width = Int(imageView.frame.width)
            let height = Int(imageView.frame.height)
            let error = LocalizableString.errorLoadingImage
                .localized()
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let errorUrl: String
            if let error = error {
                errorUrl = "https://via.placeholder.com/\(width)x\(height)?text=\(error)"
            } else {
                errorUrl = "https://via.placeholder.com/\(width)x\(height)"
            }

            let imageUrl = URL(string: errorUrl)!
            imageView.sd_setImage(with: imageUrl)

            return
        }

        imageView.sd_setImage(with: url)
    }

    func renderRecipeTitle(_ title: String) {
        titleLabel.text = title
    }

    func renderRecipeIngredients(_ ingredients: [String]) {
        ingredientsLabel.text = ingredients.joined(separator: ", ")
    }
}
