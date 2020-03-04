//
//  TranslatorService.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 22/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

class TranslatorService {
    
    private let translatorSession: URLSession
    private static let translatorURL = URL(string: "https://translation.googleapis.com/language/translate/v2/")!
    private let target = ["target=EN", "target=FR"]
    private let source = ["source=fr", "source=en"]
    private let translatorAPIKey = valueForAPIKey(named: "TranslatorKey")

    
    init(translatorSession: URLSession = .init(configuration: .default)) {
        self.translatorSession = translatorSession
    }
    /// Networking call to google.translate for get the translation wanted.
    func postTranslation(
        textToTranslate: String,
        languageIndex: Int,
        callback: @escaping (TranslationDataClass?, Error?) -> Void)
    {
        
        var request = URLRequest(url: TranslatorService.translatorURL)
        request.httpMethod = "POST"
        let body="key=\(translatorAPIKey)&\(target[languageIndex])&q=\(textToTranslate)&format=text&\(source[languageIndex])"
        request.httpBody = body.data(using: .utf8)
        let task = translatorSession.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let responseJSON = try? JSONDecoder().decode(TranslationData.self, from: data)
                else {
                    callback(nil, error)
                    return
            }
            callback(responseJSON.data, error)
        }
        task.resume()
    }
}
