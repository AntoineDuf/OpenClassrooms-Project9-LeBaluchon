//
//  ConfigureWeatherViewController.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 22/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

class ConfigureWeatherViewController: UIViewController {
    @IBOutlet weak var firstCity: UITextField!
    
    @IBOutlet weak var secondCity: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func validateButton(_ sender: Any) {
        city.removeAll()
        city.insert(firstCity.text!, at: 0)
        city.insert(secondCity.text!, at: 1)
        dismiss(animated: true, completion: nil)
    }
}
