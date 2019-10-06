//
//  MockRecipeEndpoints.swift
//  RecipeSearchTests
//
//  Created by Pablo Sanchez Egido on 06/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import Foundation
@testable import RecipeSearch

enum MockRecipeEndpoints {
    case search(RecipeSearchMode)
}

// MARK: - Endpoint
extension MockRecipeEndpoints: Endpoint {
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
            case .by(let name, _):
                return name
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
