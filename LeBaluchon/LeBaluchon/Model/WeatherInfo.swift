//
//  WeatherInfo.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 24/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import Foundation


/// Struct for decode the Json api return.
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


