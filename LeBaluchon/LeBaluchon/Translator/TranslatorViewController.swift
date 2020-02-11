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
    @IBOutlet private weak var usLabelField: UILabel!
    
    var viewModel: TranslatorViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
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

private extension TranslatorViewController{
    @IBAction func traductionButton(_ sender: Any) {
        translate()
    }
    
    func translate() {
        let text = frenchTextView.text
        viewModel.translate(text: text)
    }
    
    func configureViewModel() {
        viewModel.translateHandler = { [weak self] translations in
            guard let me = self else { return }
            DispatchQueue.main.async {
                let text = translations.first?.translatedText
                me.usLabelField.text = text
            }
        }
    }
}
