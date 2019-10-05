//
//  AppJsonDecoder.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo. All rights reserved.
//

import Foundation

struct AppJsonDecoder: AppDecoder {
    func decode<T>(_ data: Any, as: T.Type) throws -> T where T: Decodable {
        guard let json = data as? [String: Any] else {
            throw AppError.invalidJson
        }

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json)
            return try JSONDecoder().decode(T.self, from: jsonData)
        } catch {
            throw AppError.invalidJson
        }
    }
}
