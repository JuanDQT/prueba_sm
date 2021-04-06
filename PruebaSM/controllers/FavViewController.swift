//
//  ViewController.swift
//  PruebaSM
//
//  Created by Juan on 1/4/21.
//

import UIKit
import Kingfisher

// Controlador categorias guardadas, muy parecida al ViewController.
class FavViewController: MyUIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    
    // Vars
    var dataList: [Group]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(responseGroups(_:)), name: Notification.Name(rawValue: "GET_FAVS"), object: nil)
        
        doRefresh((Any).self)
        
    }

    @objc func responseGroups(_ notification: Notification) {
        let data = notification.userInfo as! [String: [Group]]
        
        self.lblNoData.isHidden = true
        self.tableView.isHidden = false
        showLoadingAlert(value: false)

        DispatchQueue.main.async {
            self.dataList = data["items"]
                  self.tableView.reloadData()
        }
    }
    
    @IBAction func doRefresh(_ sender: Any) {
        SyncData().getFavs()
    }
}



// MARK: - Extensions, Delegates
extension FavViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "CELL_ID", for: indexPath) as! MyCellController

    if let items = dataList, let img = items[indexPath.row].defaultImageUrl {
        cell.ivBackground.kf.setImage(with: URL(string: img)) {_ in
            cell.setNeedsLayout()
            
            UIView.performWithoutAnimation {
                                tableView.beginUpdates()
                                tableView.endUpdates()
                            }
        }

        cell.lblName.text = items[indexPath.row].name
        let date = items[indexPath.row].date.toStringDate()
        cell.lblFecha.text = date
        if let description = items[indexPath.row].descriptionShort {
            cell.lblDescription.text = description
        }
    }
    return cell

  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let data = dataList else { return 0 }

    return dataList!.count
    }
}

