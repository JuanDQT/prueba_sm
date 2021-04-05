//
//  Tools.swift
//  PruebaSM
//
//  Created by Juan on 5/4/21.
//

import Foundation
import Alamofire
import UIKit

extension UIViewController {

    func showAlert(title: String, message: String, showButtom: Bool = true) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)

        if(showButtom) {
            alert.addAction(aceptar)
        }
        
        self.present(alert, animated: true, completion: nil)
        return alert
    }
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
