//
//  ConverterService.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 22/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

class ConverterService {
    let converterURL = URL(string: "http://data.fixer.io/api/latest?access_key=a306e0d2d8549c5c0471b10bb9b86e2f&base=EUR&symbols=USD")!
    let converterSession = URLSession(configuration: .default)
    var task: URLSessionDataTask?
    
    func getRate(callback: @escaping (Bool, Float?) -> Void) {
        task?.cancel()
        task = converterSession.dataTask(with: converterURL) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Currency.self, from: data),
                    let rate = responseJSON.rates["USD"] else {
                        callback(false, nil)
                        return
                }
                callback(true, rate)
            }
        }
        task?.resume()
    }
}
