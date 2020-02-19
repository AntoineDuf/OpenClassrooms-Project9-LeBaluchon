//
//  MainTabBarController.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 05/02/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()
        viewControllers?.forEach { viewController in
            guard let navVC = viewController as? UINavigationController else { return }
            if let translatorVC = navVC.viewControllers.first as? TranslatorViewController {
                translatorVC.viewModel = TranslatorViewModel()
            } else if let weatherVC = navVC.viewControllers.first as?
                WeatherViewController {
                weatherVC.viewModel = WeatherViewModel()
            } else if let converterVC = navVC.viewControllers.first as?
                ConverterViewController {
                converterVC.viewModel = ConverterViewModel()
            }
        }
    }
}
