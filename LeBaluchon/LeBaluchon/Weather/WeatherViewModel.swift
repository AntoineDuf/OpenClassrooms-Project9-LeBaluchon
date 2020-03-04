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
    var city = ["Pélissanne", "New York"]
    
    var weatherService = WeatherService()
    
    init(weatherService: WeatherService = .init()) {
        self.weatherService = weatherService
    }
}

// MARK: - Methods.
extension WeatherViewModel {
    /// Method that configure the cells titles.
    func viewForHeader(in section: Int) -> UIView {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        let text = section == 0 ? "Pélissanne" : "New York"
        label.text = text
        return label
    }
    
    /// Method that launch the api call sendback the answer to the handlers for the first city.
    func refreshWeatherCityOne() {
        weatherService.getWeather(city: city[0]) { (data, error)  in
            if let data = data {
                let infoCityOne = Info(
                    temperature: "\(Int(data.main.temp))°",
                    condition: data.weather[0].description.description.capitalizeFirstLetter,
                    wind: "\(Int(data.wind.speed * 3.6))km/h",
                    image: String(data.weather[0].icon),
                    compass: self.updateWindIcon(condition: data.wind.deg)[0],
                    direction: self.updateWindIcon(condition: data.wind.deg)[1]
                )
                self.weatherCityOneHandler(infoCityOne)
            } else {
                let message = error?.localizedDescription ?? "Une erreur est survenue."
                self.errorHandler(message)
            }
        }
    }
    
    /// Method that launch the api call sendback the answer to the handlers for the second city.
    func refreshWeatherCityTwo() {
        weatherService.getWeather(city: city[1]) { (data, error)  in
            if let data = data {
                let infoCityTwo = Info(
                    temperature: "\(Int(data.main.temp))°",
                    condition: data.weather[0].description.description.capitalizeFirstLetter,
                    wind: "\(Int(data.wind.speed * 3.6))km/h",
                    image: String(data.weather[0].icon),
                    compass: self.updateWindIcon(condition: data.wind.deg)[0],
                    direction: self.updateWindIcon(condition: data.wind.deg)[1]
                )
                self.weatherCityTwoHandler(infoCityTwo)
            } else {
                let message = error?.localizedDescription ?? "Une erreur est survenue."
                self.errorHandler(message)
            }
        }
    }
}

// MARK: - Weather property and methods.
extension WeatherViewModel {
    /// This struct enables saving the info of api answer.
    struct Info {
        let temperature: String
        let condition: String
        let wind: String
        let image: String
        let compass: String
        let direction: String
    }
    
    /// This method translate the wind degree send by the api to a string dictionnary with the info for the display.
    func updateWindIcon(condition: Int) -> [String] {
      switch (condition) {
      case 0...22:
        return ["IconCompassN", "Nord"]
      case 333...360:
        return ["IconCompassN","Nord"]
      case 23...67:
        return ["IconCompassN-E","Nord-est"]
      case 68...112:
        return ["IconCompassE", "Est"]
      case 113...157:
        return ["IconCompassS-E", "Sud-est"]
      case 158...202:
        return ["IconCompassS", "Sud"]
      case 203...247:
        return ["IconCompassS-O", "Sud-ouest"]
      case 248...292:
        return ["IconCompassO", "Ouest"]
      case 293...337:
        return ["IconCompassN-O", "Nord-Ouest"]
      default :
        return ["Erreur", "Erreur"]
      }
    }
}
