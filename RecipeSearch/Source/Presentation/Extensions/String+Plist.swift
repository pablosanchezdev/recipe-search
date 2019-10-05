//
//  String+Plist.swift
//  RecipeSearch
//
//  Created by Pablo Sanchez Egido on 05/10/2019.
//  Copyright © 2019 Pablo Sanchez. All rights reserved.
//

import Foundation

extension String {
    func fromPlist() -> String? {
        return Bundle.main.infoDictionary?[self] as? String
    }
}
