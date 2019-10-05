//
//  AlamofireApiClient.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import Foundation
import Alamofire

struct AlamofireApiClient: ApiClient {
    func makeRequest(to endpoint: Endpoint, completion: @escaping (Result<Any>) -> Void) {
        Alamofire
            .request(endpoint.path, method: endpoint.httpMethod.toAlamofireHTTPMethod())
            .responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    completion(.success(json))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

fileprivate extension HttpMethod {
    func toAlamofireHTTPMethod() -> HTTPMethod {
        switch self {
        case .get:
            return .get
        }
    }
}
