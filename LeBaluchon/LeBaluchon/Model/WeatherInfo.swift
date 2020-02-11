//
//  WeatherInfo.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 24/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation

var city = ["Pélissanne", "New York"]

struct WeatherInfo: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

struct Weather: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Float
}

struct Wind: Decodable {
    let speed: Float
    let deg: Int
}

struct City {
    var city: String?
    var country: String?

    enum CodingKeys: String, CodingKey {
        case nameCity = "name"
        case nameCountry = "country"
    }


}

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
    return ["dunno", "dunno"]
  }
}
