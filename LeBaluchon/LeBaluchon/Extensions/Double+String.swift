//
//  Double+String.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 25/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

extension Double {
    var toEuro: String {
        let convert = self
        return "\(String(format: "%.2f", convert))€"
    }
    
    var toDollar: String {
        let convert = self
        return "\(String(format: "%.2f", convert))$"
    }
}
