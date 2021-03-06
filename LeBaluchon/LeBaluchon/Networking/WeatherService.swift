//
//  WeatherService.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 22/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

class WeatherService {
    private let weatherSession: URLSession
    private let weatherAPIKey = valueForAPIKey(named: "WeatherKey")
    
    init(weatherSession: URLSession = .init(configuration: .default)) {
        self.weatherSession = weatherSession
    }
    /// Networking call the weather city data.
    func getWeather(city: String, callback: @escaping (WeatherInfo?, Error?) -> Void) {
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&units=metric&lang=fr&APPID=\(weatherAPIKey)")!
        let task = weatherSession.dataTask(with: weatherURL) { (data, response, error) in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let responseJSON = try? JSONDecoder().decode(WeatherInfo.self, from: data)
                else {
                    callback(nil, error)
                    return
            }
            callback(responseJSON, error)
        }
        task.resume()
    }
}

