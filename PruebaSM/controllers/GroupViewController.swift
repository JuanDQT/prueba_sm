//
//  GroupViewController.swift
//  PruebaSM
//
//  Created by Juan on 5/4/21.
//

import Foundation
import UIKit
import RealmSwift

// Controlador detalles categoria
class GroupViewController: MyUIViewController {
    
    @IBOutlet weak var ivBackground: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblShortDescription: UILabel!
    @IBOutlet weak var btnLikeOff: UIButton!
    @IBOutlet weak var viewImage: UIView!
    
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
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        viewImage.isUserInteractionEnabled = true
        viewImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIView
        
        self.performSegue(withIdentifier: "GO_MEDIA_CONTROLLER", sender:self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GO_MEDIA_CONTROLLER" {
            if let destinationVC = segue.destination as? ImageSliderController {
                destinationVC.groupId = group!.id
            }
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
