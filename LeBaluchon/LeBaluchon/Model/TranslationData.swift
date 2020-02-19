//
//  TranslatorData.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 05/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

var target = ["target=EN", "target=FR"]
var source = ["source=fr", "source=en"]

struct TranslationData: Decodable {
    let data: TranslationDataClass
}

struct TranslationDataClass: Decodable {
    let translations: [Translation]
}

struct Translation: Decodable {
    let translatedText: String
}
