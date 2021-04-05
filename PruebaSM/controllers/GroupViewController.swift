//
//  GroupViewController.swift
//  PruebaSM
//
//  Created by Juan on 5/4/21.
//

import Foundation
import UIKit

class GroupViewController: MyUIViewController {
    
    @IBOutlet weak var ivBackground: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblShortDescription: UILabel!
    
    var group: Group?

    override func viewDidLoad() {
        if let g = group {
            
            if let url = g.defaultImageUrl {
                ivBackground.kf.setImage(with: URL(string: url))
            }
            
            
            lblName.text = g.name
            let date = g.date.toStringDate()
            lblFecha.text = date
            if let description = g.description {
                tvDescription.text = description
            }
            if let shortDescription = g.descriptionShort {
                lblShortDescription.text = shortDescription
            }

 
        }
    }
}
