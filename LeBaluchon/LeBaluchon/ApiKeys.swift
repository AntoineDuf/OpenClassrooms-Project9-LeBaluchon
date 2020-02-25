//
//  ApiKeys.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 25/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

// Method that gets the .gitignore API Keys from .plist
func valueForAPIKey(named keyname: String) -> String {
  let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
  let plist = NSDictionary(contentsOfFile: filePath!)
  let value = plist?.object(forKey: keyname) as! String
  return value
}
