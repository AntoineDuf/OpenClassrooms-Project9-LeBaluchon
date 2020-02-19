//
//  TranslatorViewModel.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 05/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

struct TranslatorViewModel {
    var translateHandler: (_ translations: [Translation]) -> Void = {_ in }
    var errorHandler: (_ message: String) -> Void = {_ in }
    var languageSetup = 0
    private let translatorService: TranslatorService
    
    init(translatorService: TranslatorService = .init()) {
        self.translatorService = translatorService
    }
}

extension TranslatorViewModel {
    func viewForHeader(in section: Int) -> UIView {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        let text: String
        if languageSetup == 0 {
            text = section == 0 ? "Français" : "Anglais"
        } else {
            text = section == 0 ? "Anglais" : "Français"
        }
        label.text = text
        return label
    }

    
    mutating func configLangage() {
        self.languageSetup = languageSetup == 0 ? 1 : 0
    }
    
    func translate(text: String!) {
        translatorService.postTranslation(textToTranslate: text, languageSetup: languageSetup) { (data, error) in
            if let data = data {
                self.translateHandler(data.translations)
            } else {
                let message = error?.localizedDescription ?? "Une erreur est survenue."
                self.errorHandler(message)
            }
        }
    }
}
