//
//  String+String.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 03/03/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

extension String {
    var capitalizeFirstLetter: String {
        let text = self
        return prefix(1).uppercased() + text.lowercased().dropFirst()
    }
}
