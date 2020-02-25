//
//  TranslatorViewModel.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 05/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

class TranslatorViewModel {
    var translateHandler: (_ translations: [Translation]) -> Void = {_ in }
    var errorHandler: (_ message: String) -> Void = {_ in }
    var selectedLanguage = Languages.French

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
        switch selectedLanguage {
        case .French:
            text = section == 0 ? Languages.French.rawValue : Languages.English.rawValue
        case .English:
            text = section == 0 ? Languages.English.rawValue : Languages.French.rawValue
        }
        label.text = text
        return label
    }

    
    func toggleLanguage() {
        self.selectedLanguage = selectedLanguage == Languages.French ? Languages.English : Languages.French
    }
    
    func translate(text: String!) {
        let languageIndex = selectedLanguage == .French ? 0 : 1
        translatorService.postTranslation(textToTranslate: text, languageIndex: languageIndex) { (data, error) in
            if let data = data {
                self.translateHandler(data.translations)
            } else {
                let message = error?.localizedDescription ?? "Une erreur est survenue."
                self.errorHandler(message)
            }
        }
    }
}

extension TranslatorViewModel {
    enum Languages: String {
        case French = "Français"
        case English = "Anglais"
    }
}

