//
//  Tools.swift
//  PruebaSM
//
//  Created by Juan on 5/4/21.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
