//
//  AppDecoder.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo. All rights reserved.
//

import Foundation

protocol AppDecoder {
    func decode<T>(_ value: Any, as: T.Type) throws -> T where T: Decodable
}
