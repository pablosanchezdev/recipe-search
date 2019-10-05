//
//  ApiClient.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

protocol ApiClient {
    func makeRequest(to endpoint: Endpoint, completion: @escaping (Result<Any>) -> Void)
}
