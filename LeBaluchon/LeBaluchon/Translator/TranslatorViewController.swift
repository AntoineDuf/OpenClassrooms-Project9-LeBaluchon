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

// MARK: - Interaction, buttons.
private extension TranslatorViewController {
    // Dismiss the keyboard if user tap anywhere on the screen.
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        frenchTextView.resignFirstResponder()
    }
    
    // Validate button that start the translation.
    @IBAction func traductionButton(_ sender: Any) {
        activityIndicator.startAnimating()
        translate()
    }
    
    // Reverse button that inverse the configuration of the two language.
    @IBAction func reverseButton(_ sender: Any) {
        viewModel.toggleLanguage()
        frenchTextView.text = ""
        usTraductionLabel.text = ""
        tableView.reloadData()
    }
}

// MARK: - Translation methods.
private extension TranslatorViewController {
    /// Launch the translation in the viewModel
    func translate() {
        activityIndicator.startAnimating()
        let text = frenchTextView.text
        viewModel.translate(text: text)
    }
    
    /// Configure the two closures who manage the two states of translation request.
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

// MARK: - Display method.
extension TranslatorViewController {
    override func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        viewModel.viewForHeader(in: section)
    }
}
