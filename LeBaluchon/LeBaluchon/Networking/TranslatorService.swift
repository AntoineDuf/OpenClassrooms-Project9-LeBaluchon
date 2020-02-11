//
//  TranslatorService.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 22/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

class TranslatorService {
    private static let translatorURL = URL(string: "https://translation.googleapis.com/language/translate/v2/")!
    
    func getTranslation(textToTranslate: String, callback: @escaping (Bool, TranslationDataClass?) -> Void) {
        var request = URLRequest(url: TranslatorService.translatorURL)
        request.httpMethod = "POST"
        
        let body = "key=AIzaSyDBysRiBCnIQm_Lyz9-G_RAyHuyo2P9Qfs&target=EN&q=\(textToTranslate)&format=text&source=fr"
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                    callback(false, nil)

                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(TranslationData.self, from: data) else{
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON.data)
            }
        }
        task.resume()
    }
}
