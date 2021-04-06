//
//  SyncData.swift
//  PruebaSM
//
//  Created by Juan on 2/4/21.
//

import UIKit
import SwiftyJSON
import Alamofire
import RealmSwift

class SyncData {
    
    let BASE_URL = "https://practica-slashmobility.firebaseio.com"
    let GET_GROUPS = "/groups.json"

    func getGroups() {

        // Peticion al servidor, json model

        AF.request(BASE_URL + GET_GROUPS, method: .get).responseDecodable(of: [Group].self) {
            response in
            
            guard let groups = response.value else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "ERROR_NETWORK"), object: nil, userInfo: nil)
                return
            }
            
            let realm = try! Realm()

            try! realm.write {
                for item in groups {
                    realm.add(item, update: .modified)
                }
            }
            
            let items = Array(realm.objects(Group.self))
            
            if items.count > 0 {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "GET_GROUPS"), object: nil, userInfo: ["items": items])
            }

        }
    }

    /*
    func getTeamById(id: String, completion: @escaping(Team) -> Void) {
        dataTask?.cancel()
            
        if var urlComponents = URLComponents(string: BASE_URL + "teams/\(id)?api_token=\(API_TOKEN)") {

            guard let url = urlComponents.url else {
                return
            }
          
            print(url)
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in defer {
              self?.dataTask = nil
            }

            let outputStr = String(data: data!, encoding: String.Encoding.utf8) as! String
            print(outputStr)

            // TODO: verificar porque arroja error.
            if let _ = error {
              //print(e.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                do {
                    let json = try JSON(data: data)
                    let jsonData = json["data"]
                    let player: Team = try JSONDecoder().decode(Team.self, from: (jsonData.rawString()?.data(using: .utf8))!)
                    print(player)
                    completion(player)
                } catch {
                    print(error.localizedDescription)
                }
            }
          }
            dataTask?.resume()
        }
    }
    */
    

}
