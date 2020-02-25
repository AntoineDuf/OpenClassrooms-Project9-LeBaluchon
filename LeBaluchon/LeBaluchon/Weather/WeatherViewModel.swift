//
//  WeatherViewModel.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 04/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

struct WeatherViewModel {
    var weatherCityOneHandler: (_ infoCityOne: Info) -> Void = {_ in }
    var weatherCityTwoHandler: (_ infoCitytwo: Info) -> Void = {_ in }
    var errorHandler: (_ message: String) -> Void = {_ in }
    var weatherService = WeatherService()
    
    init(weatherService: WeatherService = .init()) {
        self.weatherService = weatherService
    }
    
    func viewForHeader(in section: Int) -> UIView {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        let text = section == 0 ? "Pélissanne" : "New York"
        label.text = text
        return label
    }
    
    func refreshWeatherCityOne() {
        weatherService.getWeather(city: city[0]) { (data, error)  in
            if let data = data {
                let infoCityOne = Info(
                    temperature: "\(Int(data.main.temp))°",
                    condition: " \(data.weather[0].description.description)",
                    wind: "\(Int(data.wind.speed * 3.6))km/h",
                    image: String(data.weather[0].icon),
                    compass: updateWindIcon(condition: data.wind.deg)[0],
                    direction: updateWindIcon(condition: data.wind.deg)[1]
                )
                self.weatherCityOneHandler(infoCityOne)
            } else {
                let message = error?.localizedDescription ?? "Une erreur est survenue."
                self.errorHandler(message)
            }
        }
    }
    
    func refreshWeatherCityTwo() {
        weatherService.getWeather(city: city[1]) { (data, error)  in
            if let data = data {
                let infoCityTwo = Info(
                    temperature: "\(Int(data.main.temp))°",
                    condition: " \(data.weather[0].description.description)",
                    wind: "\(Int(data.wind.speed * 3.6))km/h",
                    image: String(data.weather[0].icon),
                    compass: updateWindIcon(condition: data.wind.deg)[0],
                    direction: updateWindIcon(condition: data.wind.deg)[1]
                )
                self.weatherCityTwoHandler(infoCityTwo)
            } else {
                let message = error?.localizedDescription ?? "Une erreur est survenue."
                self.errorHandler(message)
            }
        }
    }
}

extension WeatherViewModel {
    struct Info {
        let temperature: String
        let condition: String
        let wind: String
        let image: String
        let compass: String
        let direction: String
    }
}
