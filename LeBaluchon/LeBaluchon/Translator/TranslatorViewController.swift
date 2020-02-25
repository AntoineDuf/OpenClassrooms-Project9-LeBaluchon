//
//  TranslatorViewController.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 22/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

class TranslatorViewController: UITableViewController {
    
    @IBOutlet private weak var frenchTextView: UITextView!
    @IBOutlet private weak var usTraductionLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: TranslatorViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        frenchTextView.becomeFirstResponder()
    }
}

extension TranslatorViewController {
    override func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        viewModel.viewForHeader(in: section)
    }
}

private extension TranslatorViewController {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        frenchTextView.resignFirstResponder()
    }
    
    @IBAction func traductionButton(_ sender: Any) {
        activityIndicator.startAnimating()
        translate()
    }
    
    @IBAction func reverseButton(_ sender: Any) {
        viewModel.toggleLanguage()
        frenchTextView.text = ""
        usTraductionLabel.text = ""
        tableView.reloadData()
    }
}

private extension TranslatorViewController {
    func translate() {
        activityIndicator.startAnimating()
        let text = frenchTextView.text
        viewModel.translate(text: text)
    }
    
    func configureViewModel() {
        viewModel.translateHandler = { [weak self] translations in
            guard let me = self else { return }
            DispatchQueue.main.async {
                let text = translations.first?.translatedText
                me.usTraductionLabel.text = text
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
