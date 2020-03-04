//
//  ConverterService.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 22/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

class ConverterService {
    private let converterSession: URLSession
    private let converterAPIKey = valueForAPIKey(named: "ConverterKey")

    init(converterSession: URLSession = .init(configuration: .default)) {
        self.converterSession = converterSession
    }
    /// Networking call to fixier.io for get the currency rates.
    func getRate(callback: @escaping (Currency?, Error?) -> Void) {
        let converterURL = URL(string: "http://data.fixer.io/api/latest?access_key=\(converterAPIKey)&base=EUR&symbols=USD")!
        let task = converterSession.dataTask(with: converterURL) { (data, response, error) in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let responseJSON = try?
                    JSONDecoder().decode(Currency.self, from: data)
                else {
                    callback(nil, error)
                    return
            }
            callback(responseJSON, error)
        }
        task.resume()
    }
}
