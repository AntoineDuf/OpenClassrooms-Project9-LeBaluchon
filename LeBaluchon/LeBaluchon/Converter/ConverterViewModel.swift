//
//  ConverterViewModel.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 13/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

class ConverterViewModel {
    var converterHandler: (_ convertText: String) -> Void = {_ in }
    var errorHandler: (_ message: String) -> Void = {_ in }
    var currencySetup = Currency.Euro
    
    private let converterService: ConverterService
    
    init(converterService: ConverterService = .init()) {
        self.converterService = converterService
    }
}

// MARK: - Methods.
extension ConverterViewModel {
    /// Method that configure the cells titles.
    func viewForHeader(in section: Int) -> UIView {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        let text: String
        switch currencySetup {
        case .Euro:
            text = section == 0 ? "EUR" : "USD"
        case .USDollar:
            text = section == 0 ? "USD" : "EUR"
        }
        label.text = text
        return label
    }
    
    /// Method that changes the configuration of the conversion currency.
    func toggleCurrency() {
        self.currencySetup = currencySetup == Currency.Euro ? Currency.USDollar : Currency.Euro
    }
    
    /// Method that launch the api call, do the conversion and sendback the answer to the handlers.
    func getConvert(text: String) {
        guard let value = Double(text) else {
            errorHandler("Merci d'entrer une valeur correcte.")
            return
        }
        converterService.getRate() { (data, error) in
            guard let data = data,
            let rate = data.rates["USD"]
                else {
                    let message = error?.localizedDescription ?? "Une erreur est survenue."
                    self.errorHandler(message)
                    return
            }
            let currency = Double(rate)
            let convertText: String
            if self.currencySetup == Currency.Euro {
                let convert = value * currency
                convertText = convert.toDollar
            } else {
                let convert = value / currency
                convertText = convert.toEuro
            }
            self.converterHandler(convertText)
        }
    }
}

// MARK: - Currency property.
extension ConverterViewModel {
    enum Currency: String {
        case Euro = "EUR"
        case USDollar = "USD"
    }
}
