//
//  Groups.swift
//  PruebaSM
//
//  Created by Juan on 5/4/21.
//
import Foundation

struct Group: Decodable {
    let id: Int
    let name: String
    let date: Int
    let defaultImageUrl: String?
    let description: String?
    let descriptionShort: String?
}
