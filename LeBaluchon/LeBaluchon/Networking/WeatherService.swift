//
//  WeatherService.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 22/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

class WeatherService {
    let weatherSession = URLSession(configuration: .default)
    var task: URLSessionDataTask?
    
    func getWeather(city: String, callback: @escaping (Bool, WeatherInfo?) -> Void) {
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&units=metric&lang=fr&APPID=0bea5b117f2e763e5650645d21327e25")!
        task = weatherSession.dataTask(with: weatherURL) { (data, response, error) in DispatchQueue.main.async {
            guard let data = data, error == nil else {
                callback(false, nil)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(false, nil)
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(WeatherInfo.self, from: data) else {
                callback(false, nil)
                return
            }
            callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}

