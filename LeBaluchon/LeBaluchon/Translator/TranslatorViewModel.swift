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
    private let translatorService: TranslatorService
    
    init(translatorService: TranslatorService = .init()) {
        self.translatorService = translatorService
    }
}

extension TranslatorViewModel {
    func viewForHeader(in section: Int) -> UIView {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        let text = section == 0 ? "Français" : "Anglais"
        label.text = text
        return label
    }
    
    func translate(text: String!) {
        translatorService.getTranslation(textToTranslate: text){ (success, data) in
            if success, let data = data {
                self.translateHandler(data.translations)
                
            }
        }
    }
}
