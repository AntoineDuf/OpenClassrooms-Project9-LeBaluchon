//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 22/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    private let weather = WeatherService()
    
    @IBOutlet weak var nameLabelFirstCity: UILabel!
    @IBOutlet weak var temperatureLabelFirstCity: UILabel!
    @IBOutlet weak var conditionLabelFirstCity: UILabel!
    @IBOutlet weak var windLabelFirstCity: UILabel!
    @IBOutlet weak var nameLabelSecondCity: UILabel!
    @IBOutlet weak var temperatureLabelSecondCity: UILabel!
    @IBOutlet weak var conditionLabelSecondCity: UILabel!
    @IBOutlet weak var windLabelSecondCity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWeather()
    }
}

private extension WeatherViewController {
    @IBAction func refreshButton(_ sender: Any) {
        displayWeather()
    }
}

private extension WeatherViewController {
    func refreshWeather(city: String, name: UILabel, temperature: UILabel, condition: UILabel, wind: UILabel) {
        weather.getWeather(city: city) { [weak self] (success, weather) in
            guard let me = self else { return }
            DispatchQueue.main.async {
                if success == true {
                    name.text = city
                    temperature.text = "Température:  \(weather!.main.temp.description)"
                    condition.text = "Condition: \(weather!.weather[0].main)"
                    wind.text = "Vent: \(weather!.wind.speed.description)"
                } else {
                    me.alert(title: "Erreur", message: "Une erreur est survenue vérifier la Ville saisie ou la connexion internet")
                }
            }
        }
    }
    
    func displayWeather() {
        refreshWeather(city: city[0], name: nameLabelFirstCity, temperature: temperatureLabelFirstCity, condition: conditionLabelFirstCity, wind: windLabelFirstCity)
        refreshWeather(city: city[1], name: nameLabelSecondCity, temperature: temperatureLabelSecondCity, condition: conditionLabelSecondCity, wind: windLabelSecondCity)
    }
}
