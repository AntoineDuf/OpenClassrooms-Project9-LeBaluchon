//
//  ConverterViewController.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 22/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    let converter = ConverterService()
    
    @IBOutlet weak var firstField: UITextField!
    @IBOutlet weak var secondField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension ConverterViewController {
    
    @IBAction func convertButton(_ sender: Any) {
        converter.getRate { (success, rate) in
            guard success == true else {
                return
            }
            self.convert(rate: rate!)
        }
    }
}

private extension ConverterViewController {
    func convert(rate: Float) {
        let textFloat = Float(firstField.text!)!
        let result = textFloat * rate
        secondField.text = String(format: "%.2f", result)
    }
}
