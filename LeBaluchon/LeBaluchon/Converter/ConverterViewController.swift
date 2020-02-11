//
//  ConverterViewController.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 22/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

class ConverterViewController: UITableViewController {
    let converter = ConverterService()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var labelField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    @IBAction func dismissKeyboard(_ sender: Any) {
        textField.resignFirstResponder()
    }
}

private extension ConverterViewController {
    @IBAction func convertButton(_ sender: Any) {
        converter.getRate { (success, rate) in
            guard success == true, let rate = rate else {
                return
            }
            self.convert(rate: rate)
        }
    }
}

private extension ConverterViewController {
    func convert(rate: Float) {
        guard let text = textField.text else { return self.alert(title: "Erreur", message: "Echec")}
        guard let textFloat = Float(text) else { return self.alert(title: "Erreur", message: "Echec")}
        let result = textFloat * rate
            labelField.text = String(format: "%.2f", result)
        }
    }

extension ConverterViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        let text = section == 0 ? "EUR" : "USD"
        label.text = text
        return label
    }
}
