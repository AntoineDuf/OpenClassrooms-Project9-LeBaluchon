//
//  TranslatorViewController.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 22/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

class TranslatorViewController: UITableViewController {
    
    @IBOutlet weak var frenchTextView: UITextView!
    @IBOutlet weak var usLabelField: UILabel!
}

extension TranslatorViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        let text = section == 0 ? "Français" : "Anglais"
        label.text = text
        return label
    }
}

private extension TranslatorViewController{
    @IBAction func traductionButton(_ sender: Any) {
        translate()
    }
    
    func translate() {
        guard let text = frenchTextView.text else {
            return self.alert(title: "Erreur", message: "La traduction a échoué.")}
        TranslatorService.getTranslation(textToTranslate: text){ (success, data) in
            DispatchQueue.main.async {
                if success, let data = data {
                    for translation in data.translations{
                        self.usLabelField.text = translation.translatedText
                    }
                }
            }
        }
    }
}
