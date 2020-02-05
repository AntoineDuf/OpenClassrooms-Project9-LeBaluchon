//
//  WeatherViewModel.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 04/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

class WeatherViewModel {
    
    let weather = WeatherService()
    var temperature = ""
    var condition = ""
    var wind = ""
    var image = ""
    var compass = ""
    var directionLabel = ""
    var error = false
    
    func refreshWeather(city: String) {
        weather.getWeather(city: city) { [weak self] (success, weather) in
            guard let me = self else { return }
            DispatchQueue.main.async {
                if success == true, let weather = weather {
                    me.temperature = "\(String(Int(weather.main.temp)))°"
                    me.condition = " \(weather.weather[0].description.description)"
                    me.wind = "\(String(Int(weather.wind.speed * 3.6))) km/h"
                    me.image = weather.weather[0].icon
                    me.compass =  updateWindIcon(condition: weather.wind.deg)[0]
                    me.directionLabel = updateWindIcon(condition: weather.wind.deg)[1]
                    return
                } else {
                    me.error = true
                }
            }
        }
    }
}
