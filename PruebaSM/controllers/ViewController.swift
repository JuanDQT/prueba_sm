//
//  ViewController.swift
//  PruebaSM
//
//  Created by Juan on 1/4/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    // Vars
    var dataList: [Data]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }


}

// MARK: - Extensions, Delegates
extension ViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "CELL_ID", for: indexPath) as! MyCellController

    if let items = dataList {
        cell.name.text = items[indexPath.row].name
        cell.age.text = items[indexPath.row].getAge()
        if let img = items[indexPath.row].image {
            cell.picture.kf.setImage(with: URL(string: img))
        }
    }
    return cell

  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let data = dataList else { return 0 }

    return dataList!.count
    }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    if let items = dataList {
        performSegue(withIdentifier: "GO_DETALL_CONTROLLER", sender: items[indexPath.row].id)
    }
  }
}
