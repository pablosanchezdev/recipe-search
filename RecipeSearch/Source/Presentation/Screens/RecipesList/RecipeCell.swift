//
//  RecipeCell.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!

    static let height: CGFloat = 80
    
    override func prepareForReuse() {
        imageView.image = nil
        titleLabel.text = ""
        ingredientsLabel.text = ""
    }

    func fill(with recipe: RecipeView) {
        imageView.sd_setImage(with: thumnailUrl(for: recipe))
        titleLabel.text = recipe.title
        ingredientsLabel.text = recipe.ingredients.joined(separator: ", ")
    }

    private func thumnailUrl(for recipe: RecipeView) -> URL {
        guard !recipe.thumbnailUrl.isEmpty,
            let url = URL(string: recipe.thumbnailUrl) else {
                let width = Int(imageView.frame.width)
                let height = Int(RecipeCell.height)
                let error = LocalizableString.errorLoadingImage
                    .localized()
                    .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                let errorUrl: String
                if let error = error {
                    errorUrl = "https://via.placeholder.com/\(width)x\(height)?text=\(error)"
                } else {
                    errorUrl = "https://via.placeholder.com/\(width)x\(height)"
                }

                return URL(string: errorUrl)!  // Be careful with '!'. In this case, we can be sure that is valid Url
        }

        return url
    }
}
