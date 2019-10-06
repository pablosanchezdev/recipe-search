//
//  RecipeRepository.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo. All rights reserved.
//

import Foundation

enum RecipeSearchMode {
    case by(name: String, page: Int)
}

protocol RecipeRepository {
    func searchRecipes(for mode: RecipeSearchMode, completion: @escaping ([Recipe]?, Error?) -> Void)
}
