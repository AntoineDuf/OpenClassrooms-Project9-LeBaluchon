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
            guard let navigationVC = viewController as? UINavigationController,
                let translatorVC = navigationVC.viewControllers.first as? TranslatorViewController
                else { return }
            translatorVC.viewModel = TranslatorViewModel()
        }
    }
}
