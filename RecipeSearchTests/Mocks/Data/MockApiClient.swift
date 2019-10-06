//
//  MockApiClient.swift
//  RecipeSearchTests
//
//  Created by Pablo Sanchez Egido on 06/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import Foundation
@testable import RecipeSearch

struct MockApiClient: ApiClient {
    func makeRequest(to endpoint: Endpoint, completion: @escaping (Result<Any>) -> Void) {
        let filePath = endpoint.path
        if let jsonData = LocalFileManager.readLocalJsonFile(name: filePath),
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) {
            completion(.success(json))
        } else {
            completion(.failure(AppError.invalidJson))
        }
    }
}
