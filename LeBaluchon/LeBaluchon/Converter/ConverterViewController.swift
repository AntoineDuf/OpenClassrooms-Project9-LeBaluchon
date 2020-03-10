//
//  ConverterViewController.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 22/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

class ConverterViewController: UITableViewController {
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var labelField: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    var viewModel: ConverterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
}

// MARK: - Interaction, buttons.
private extension ConverterViewController {
    // Dismiss the keyboard if user tap anywhere on the screen.
    @IBAction func dismissKeyboard(_ sender: Any) {
        textField.resignFirstResponder()
        tableView.reloadData()
    }
    
    // Validate button that start the conversion.
    @IBAction func convertButton(_ sender: Any) {
        activityIndicator.startAnimating()
        let text = textField.text
        viewModel.getConvert(text: text!)
    }
    
    // Reverse button that inverse the configuration of the two currency.
    @IBAction func reverseButton(_ sender: Any) {
        viewModel.toggleCurrency()
        textField.text = ""
        labelField.text = ""
        self.tableView.reloadData()
    }
}

// MARK: - Display and translation methods.
extension ConverterViewController {
    override func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        self.viewModel.viewForHeader(in: section)
    }
    
    /// Configure the two closures who manage the two states of currency request.
    private func configureViewModel() {
        viewModel.converterHandler = { [weak self] convertText in
            guard let me = self else { return }
            DispatchQueue.main.async {
                me.labelField.text = convertText
                me.activityIndicator.stopAnimating()
            }
        }
        viewModel.errorHandler = { [weak self] title in
            guard let me = self else { return }
            DispatchQueue.main.async {
                me.activityIndicator.stopAnimating()
                me.alert(title: title)
            }
        }
    }
}
