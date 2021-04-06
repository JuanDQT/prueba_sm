//
//  MyUIViewController.swift
//  PruebaSM
//
//  Created by Juan on 5/4/21.
//

import UIKit

// Clase base, de la cual extenderan el resto.
class MyUIViewController: UIViewController {
    var loadingDialog: UIAlertController?
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(errorNetwork(_:)), name: Notification.Name(rawValue: "ERROR_NETWORK"), object: nil)
    }
    
    func showLoadingAlert(value: Bool) {
        if(value) {
            loadingDialog = showAlert(title: "Cargando", message: "Descargando grupos...", showButtom: false)
        } else {
            if let _ = loadingDialog {
                loadingDialog!.dismiss(animated: false, completion: nil)
            }
        }
            
    }
    
    @objc func errorNetwork(_ notification: Notification) {
        if let _ = loadingDialog {
            loadingDialog!.dismiss(animated: false, completion: nil)
        }

        showAlert(title: "Error", message: "Error al descargar los grupos")
    }
}
