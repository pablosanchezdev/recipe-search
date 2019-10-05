//
//  RecipeAPI.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo. All rights reserved.
//

import Foundation

struct ResultsAPI: Decodable {
    let results: [RecipeAPI]
}

struct RecipeAPI: Decodable {
    let thumbnail: String
    let title: String
    let ingredients: String
}
