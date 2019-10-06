//
//  MockRemoteRecipeRepository.swift
//  RecipeSearchTests
//
//  Created by Pablo Sanchez Egido on 06/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import Foundation
@testable import RecipeSearch

struct MockRemoteRecipeRepository: RecipeRepository {
    let apiClient: ApiClient
    let decoder: AppDecoder
    
    func searchRecipes(for mode: RecipeSearchMode, completion: @escaping ([Recipe]?, Error?) -> Void) {
        let endpoint = MockRecipeEndpoints.search(mode)
        apiClient.makeRequest(to: endpoint) { (result) in
            switch result {
            case .success(let value):
                do {
                    let recipesFromApi = try self.handleResponse(value)
                    let recipes = recipesFromApi.map { $0.toRecipe() }
                    completion(recipes, nil)
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

extension MockRemoteRecipeRepository {
    private func handleResponse(_ response: Any) throws -> [RecipeAPI] {
        do {
            let result = try decoder.decode(response, as: ResultsAPI.self)
            return result.results
        } catch {
            throw error
        }
    }
}
