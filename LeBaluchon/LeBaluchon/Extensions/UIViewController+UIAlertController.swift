//
//  UIViewController+UIAlertController.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 29/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
