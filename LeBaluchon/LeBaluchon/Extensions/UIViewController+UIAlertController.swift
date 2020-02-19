//
//  UIViewController+UIAlertController.swift
//  LeBaluchon
//
//  Created by Antoine Dufayet on 29/01/2020.
//  Copyright © 2020 NatProd. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(title: String? = nil, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    enum ErrorText: Error {
        case connexionIssue
        case serverIssue
    }
    
//    func ignitErrorMessage() throws {
//        if {
//            throw ErrorText.connexionIssue
//        } else if {
//            throw ErrorText.serverIssue
//        }
//    }
//
//    func displayError() {
//        do {
//            try ignitErrorMessage()
//        } catch ErrorText.connexionIssue {
//            print("Vérifiez votre connexion.")
//        } catch ErrorText.serverIssue {
//            print("Problème de communication avec le serveur")
//        }
//    }
}
