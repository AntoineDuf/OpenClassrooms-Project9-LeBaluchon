//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 22/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

class WeatherViewController: UITableViewController {
        var viewModel = WeatherViewModel()
    var weather = WeatherService()
    
    @IBOutlet weak var temperatureLabelFirstCity: UILabel!
    @IBOutlet weak var conditionLabelFirstCity: UILabel!
    @IBOutlet weak var windLabelFirstCity: UILabel!
    @IBOutlet weak var firstCityImageWeather: UIImageView!
    @IBOutlet weak var arrowFirstCity: UIImageView!
    @IBOutlet weak var arrowDirectionFirstCity: UILabel!
    
    @IBOutlet weak var temperatureLabelSecondCity: UILabel!
    @IBOutlet weak var conditionLabelSecondCity: UILabel!
    @IBOutlet weak var windLabelSecondCity: UILabel!
    @IBOutlet weak var secondCityImageWeather: UIImageView!
    @IBOutlet weak var arrowSecondCity: UIImageView!
    @IBOutlet weak var arrowDirectionSecondCity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        requestWeather(city: city[0])
//        requestWeather(city: city[1])
        viewModel.refreshWeather(city: city[0])
        temperatureLabelFirstCity.text = viewModel.temperature
    }
}

private extension WeatherViewController {
    @IBAction func refreshButton(_ sender: Any) {
//        requestWeather(city: city[0])
//        requestWeather(city: city[1])

    }
}

extension WeatherViewController {
//    func refeshWeatherFirstCity(weatherData: WeatherInfo) {
//        self.temperatureLabelFirstCity.text = "\(String(Int(weatherData.main.temp)))°"
//        self.conditionLabelFirstCity.text = " \(weatherData.weather[0].description.description)"
//        self.windLabelFirstCity.text = "\(String(Int(weatherData.wind.speed * 3.6))) km/h"
//        self.firstCityImageWeather.image = UIImage.init(named: weatherData.weather[0].icon)
//        self.arrowFirstCity.image = UIImage.init(named: updateWindIcon(condition: weatherData.wind.deg)[0])
//        self.arrowDirectionFirstCity.text = updateWindIcon(condition: weatherData.wind.deg)[1]
//    }
//
//    func refeshWeatherSecondCity(weatherData: WeatherInfo) {
//        self.temperatureLabelSecondCity.text = "\(String(Int(weatherData.main.temp)))°"
//        self.conditionLabelSecondCity.text = " \(weatherData.weather[0].description.description)"
//        self.windLabelSecondCity.text = "\(String(Int(weatherData.wind.speed * 3.6))) km/h"
//        self.secondCityImageWeather.image = UIImage.init(named: weatherData.weather[0].icon)
//        self.arrowSecondCity.image = UIImage.init(named: updateWindIcon(condition: weatherData.wind.deg)[0])
//        self.arrowDirectionSecondCity.text = updateWindIcon(condition: weatherData.wind.deg)[1]
//    }
//
//    func requestWeather(city: String) {
//        weather.getWeather(city: city) { [weak self] (success, weather) in
//            guard let me = self else { return }
//            DispatchQueue.main.async {
//                if success == true, let data = weather, city == "Pélissanne" {
//                    me.refeshWeatherFirstCity(weatherData: data)
//                } else if success == true, let data = weather, city == "New York" {
//                    me.refeshWeatherSecondCity(weatherData: data)
//                } else {
//                    me.alert(title: "Erreur", message: "Echec")
//                }
//            }
//        }
//    }
}

extension WeatherViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        let text = section == 0 ? "Pélissanne" : "New York"
        label.text = text
        return label
    }
}


