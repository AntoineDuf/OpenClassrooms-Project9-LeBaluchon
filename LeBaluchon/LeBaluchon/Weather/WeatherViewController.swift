//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 22/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

class WeatherViewController: UITableViewController {
    var viewModel: WeatherViewModel!
    
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
        configurePullToRefresh()
        configureViewModel()
//        getWeather()
    }
}

extension WeatherViewController {
    override func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        viewModel.viewForHeader(in: section)
    }
}

private extension WeatherViewController {
    func configurePullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(getWeather),
            for: .valueChanged
        )
        self.refreshControl = refreshControl
    }
    
    @objc func getWeather(){
        viewModel.refreshWeatherCityOne()
        viewModel.refreshWeatherCityTwo()
    }
    
    func configureViewModel() {
        viewModel.weatherCityOneHandler = { [weak self] info in
            guard let me = self else { return }
            DispatchQueue.main.async {
                me.temperatureLabelFirstCity.text = info.temperature
                me.conditionLabelFirstCity.text = info.condition
                me.windLabelFirstCity.text = info.wind
                me.firstCityImageWeather.image = UIImage(named: info.image)
                me.arrowFirstCity.image = UIImage(named: info.compass)
                me.arrowDirectionFirstCity.text = info.direction
                me.refreshControl?.endRefreshing()
            }
        }
        viewModel.weatherCityTwoHandler = { [weak self] info in
            guard let me = self else { return }
            DispatchQueue.main.async {
                me.temperatureLabelSecondCity.text = info.temperature
                me.conditionLabelSecondCity.text = info.condition
                me.windLabelSecondCity.text = info.wind
                me.secondCityImageWeather.image = UIImage(named: info.image)
                me.arrowSecondCity.image = UIImage(named: info.compass)
                me.arrowDirectionSecondCity.text = info.direction
                me.refreshControl?.endRefreshing()
            }
        }
        viewModel.errorHandler = { [weak self] title in
            guard let me = self else { return }
            DispatchQueue.main.async {
                me.alert(title: title)
                me.refreshControl?.endRefreshing()
            }
        }
    }
}

