//
//  TranslatorData.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 05/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

struct TranslationData: Decodable {
    let data: TranslationDataClass
}

struct TranslationDataClass: Decodable {
    let translations: [Translation]
}

struct Translation: Decodable {
    let translatedText: String
}
