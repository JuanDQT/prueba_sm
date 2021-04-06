//
//  Groups.swift
//  PruebaSM
//
//  Created by Juan on 5/4/21.
//
import Foundation
import RealmSwift
import Realm

@objcMembers class Group: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String
    @objc dynamic var date: Int
    @objc dynamic var defaultImageUrl: String?
    @objc dynamic var descriptionLong: String?
    @objc dynamic var descriptionShort: String?
    
    //let saved = RealmOptional<Bool>()
    @objc dynamic var saved: Bool = false
    
    enum CodingKeys: String, CodingKey {
            case id, name, date, defaultImageUrl, descriptionLong, descriptionShort
        }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
