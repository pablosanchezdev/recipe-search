//
//  Endpoint.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import Foundation

enum HttpMethod {
    case get
}

protocol Endpoint {
    var httpMethod: HttpMethod { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var body: [String: Any]? { get }
}
