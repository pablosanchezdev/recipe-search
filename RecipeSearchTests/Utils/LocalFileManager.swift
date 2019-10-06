//
//  LocalFileManager.swift
//  RecipeSearchTests
//
//  Created by Pablo Sanchez Egido on 06/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import Foundation

struct LocalFileManager {
    static func readLocalJsonFile(name: String) -> Data? {
        guard let path = Bundle(for: RecipesListPresenterTests.self).path(forResource: name, ofType: "json") else { return nil }
        
        guard let jsonString = try? String(contentsOfFile: path, encoding: .utf8) else { return nil }
        
        return jsonString.data(using: .utf8)
    }
}
