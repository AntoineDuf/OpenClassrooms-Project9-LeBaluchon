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
    
    @IBAction func reverseButton(_ sender: Any) {
        viewModel.configConverter()
        self.tableView.reloadData()
    }
}

private extension ConverterViewController {
    @IBAction func convertButton(_ sender: Any) {
        activityIndicator.startAnimating()
        let text = textField.text
        viewModel.getConvert(text: text!)
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        textField.resignFirstResponder()
        tableView.reloadData()
    }
}

extension ConverterViewController {
    override func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        self.viewModel.viewForHeader(in: section)
    }
    
    func configureViewModel() {
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
                me.alert(title: title)
            }
        }
    }
}
