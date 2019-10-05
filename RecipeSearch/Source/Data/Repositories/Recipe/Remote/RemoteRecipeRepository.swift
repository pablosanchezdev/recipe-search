//
//  RemoteRecipeRepository.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo. All rights reserved.
//

import Foundation

struct RemoteRecipeRepository: RecipeRepository {
    let apiClient: ApiClient
    let decoder: AppDecoder
    
    func searchRecipes(for mode: RecipeSearchMode, completion: @escaping ([Recipe]?, Error?) -> Void) {
        let endpoint = RecipeEndpoints.search(mode)
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
                completion(nil, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

extension RemoteRecipeRepository {
    private func handleResponse(_ response: Any) throws -> [RecipeAPI] {
        do {
            let result = try decoder.decode(response, as: ResultsAPI.self)
            return result.results
        } catch {
            throw error
        }
    }
}
