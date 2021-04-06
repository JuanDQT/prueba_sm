//
//  GroupViewController.swift
//  PruebaSM
//
//  Created by Juan on 5/4/21.
//

import Foundation
import UIKit
import RealmSwift

class GroupViewController: MyUIViewController {
    
    @IBOutlet weak var ivBackground: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblShortDescription: UILabel!
    @IBOutlet weak var btnLikeOff: UIButton!
    
    var group: Group?

    override func viewDidLoad() {
        if let g = group {
            
            if let url = g.defaultImageUrl {
                ivBackground.kf.setImage(with: URL(string: url))
            }
            
            title = g.name
            
            lblName.text = g.name
            let date = g.date.toStringDate()
            lblFecha.text = date
            if let description = g.descriptionLong {
                tvDescription.text = description
            }
            if let shortDescription = g.descriptionShort {
                lblShortDescription.text = shortDescription
            }
            
            toggleLike(group: g)

 
        }
    }
    
    private func toggleLike(group: Group) {
        btnLike.isHidden = !group.saved
        btnLikeOff.isHidden = group.saved

    }
    @IBAction func doLike(_ sender: Any) {
        let realm = try! Realm()
        
        if let item = realm.objects(Group.self).filter("id = %@", group!.id).first {

            try! realm.write {
                    item.saved = !item.saved
                    toggleLike(group: item)
                }
            }
        }
}
