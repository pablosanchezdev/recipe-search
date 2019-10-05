//
//  RecipeEndpoints.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo. All rights reserved.
//

import Foundation

enum RecipeEndpoints {
    case search(RecipeSearchMode)

    var baseUrl: String {
        guard let url = AppConfig.recipesBaseUrl else { fatalError("RecipesBaseUrl must be specified") }
        return url
    }
}

// MARK: - Endpoint
extension RecipeEndpoints: Endpoint {
    var httpMethod: HttpMethod {
        switch self {
        case .search(_):
            return .get
        }
    }

    var path: String {
        switch self {
        case .search(let mode):
            switch mode {
            case .by(let name):
                return "\(baseUrl)/?q=\(name)"
            }
        }
    }

    var headers: [String : String]? {
        switch self {
        case .search(_):
            return nil
        }
    }

    var body: [String : Any]? {
        switch self {
        case .search(_):
            return nil
        }
    }
}
