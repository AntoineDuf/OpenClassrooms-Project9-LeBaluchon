//
//  ConverterViewModel.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 13/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

struct ConverterViewModel {
    var converterHandler: (_ convertText: String) -> Void = {_ in }
    var errorHandler: (_ message: String) -> Void = {_ in }
    var currencySetup = Currency.Euro
    private let converterService: ConverterService
    
    init(converterService: ConverterService = .init()) {
        self.converterService = converterService
    }
}

extension ConverterViewModel {
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
    
    mutating func toggleCurrency() {
        self.currencySetup = currencySetup == Currency.Euro ? Currency.USDollar : Currency.Euro
    }
    
    func getConvert(text: String) {
        converterService.getRate() { (data, error) in
            if let data = data {
                if self.currencySetup == Currency.Euro {
                    let currency = data.rates["USD"]
                    let convert = Double(text)! * Double(currency!)
                    let convertText = "\(String(format: "%.2f", convert))$"
                    self.converterHandler(convertText)
                } else {
                    let currency = data.rates["USD"]
                    let convert = Double(text)! / Double(currency!)
                    let convertText = "\(String(format: "%.2f", convert))€"
                    self.converterHandler(convertText)
                }
            } else {
                let message = error?.localizedDescription ?? "Une erreur est survenue."
                self.errorHandler(message)
            }
        }
    }
}

extension ConverterViewModel {
    enum Currency: String {
        case Euro = "EUR"
        case USDollar = "USD"
    }
}
