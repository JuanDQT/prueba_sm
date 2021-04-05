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

extension Int {

    func toStringDate() -> String {
        let truncatedTime = Int(self / 1000)
        let date = Date(timeIntervalSince1970: TimeInterval(truncatedTime))
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "dd/MM/yyyy"
        //formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter.string(from: date)
    }
}
