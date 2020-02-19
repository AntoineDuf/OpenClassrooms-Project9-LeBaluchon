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
    var currencySetup = 0
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
        if currencySetup == 0 {
            text = section == 0 ? "EUR" : "USD"
        } else {
            text = section == 0 ? "USD" : "EUR"
        }
        label.text = text
        return label
    }
    
    mutating func configConverter() {
        self.currencySetup = currencySetup == 0 ? 1 : 0
    }
    
    func getConvert(text: String) {
        converterService.getRate() { (data, error) in
            if let data = data {
                if self.currencySetup == 0 {
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
