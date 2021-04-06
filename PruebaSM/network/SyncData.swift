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
import ImageSlideshowKingfisher

class SyncData {
    let BASE_URL = "https://practica-slashmobility.firebaseio.com"
    let GET_GROUPS = "/groups.json"
    let GET_IMAGES = "/images/xxx.json" // xxx: parametrizable

    // Recogemos todos los grupos
    func getGroups() {
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
    
    // Buscamos las imagenes
    func getMedia(_ groupId: Int) {
        AF.request(BASE_URL + GET_IMAGES.replacingOccurrences(of: "xxx", with: "\(groupId)"), method: .get).responseJSON {
            response in
            
            switch response.result{
                case .success(let value):
                    
                    if let images = value as? [String], images.count > 0 {
                        var items: [KingfisherSource] = []
                        for res in images {
                            items.append(KingfisherSource(urlString: res)!)
                        }
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "GET_IMAGES"), object: nil, userInfo: ["items": items])
                    }
                case .failure(let error):
                    print(error.localizedDescription)

            }
        }
    }
    
    // Buscamos los guardados
    func getFavs() {
        let realm = try! Realm()
        
        let items = realm.objects(Group.self).filter("saved = %@", 1)
        if(items.count > 0) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "GET_FAVS"), object: nil, userInfo: ["items": Array(items)])
        }
    }
}
