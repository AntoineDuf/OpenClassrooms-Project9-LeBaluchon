//
//  CurrencyInfo.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 29/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

struct Currency: Decodable {
    let rates: [String: Float]
}
