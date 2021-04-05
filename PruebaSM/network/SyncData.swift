//
//  SyncData.swift
//  PruebaSM
//
//  Created by Juan on 2/4/21.
//

import UIKit
import SwiftyJSON
import Alamofire

class SyncData {
    
    let BASE_URL = "https://practica-slashmobility.firebaseio.com"
    let GET_GROUPS = "/groups.json"
    
    // MARK - : Validations
    
    func checkValidJSON(_ request: String?) throws -> JSON {
        
        if request!.count > 0 {
            if let data = request {
                if let dataFromString = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                    let json = try JSON(data: dataFromString)
                    return json
                }
            }
        }

        // Return empty JSON if any error
        return JSON([:])
    }
    /*
    func checkCommonErrors(_ response: AFDataResponse<String>, json: inout JSON) throws -> Bool {
        
        if response.result.get().isFailure {
            
            // No tienes internet
            if response.result.error._code == NSURLErrorNotConnectedToInternet {
            }
            // El servidor esta off
            if response.result.error?._code == NSURLErrorCannotConnectToHost {
            }
            // Tiempo de espera
            if response.result.error?._code == NSURLErrorTimedOut {
            }
            
            NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "NETWORK_ERROR")))
            return false
        }
        
        json = try self.checkValidJSON(response.result.value)
        return true
    }*/
    
    func getGroups() {

        // Peticion al servidor, json model

        AF.request(BASE_URL + GET_GROUPS, method: .get).responseDecodable(of: [Group].self) {
            response in
            
            guard let groups = response.value else { return }
            print("grop")
            NotificationCenter.default.post(name: Notification.Name(rawValue: "GET_GROUPS"), object: nil, userInfo: ["items": groups])

            /*
            let decoder = JSONDecoder()
                let data: Group = try decoder.decode(Group.self, from: response.data!)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "ALL_IMAGES"), object: nil, userInfo: ["imageresponse": data])
            */
            
            //var palabra: Palabras = Palabras()
            //self.getData(json: jsonResponse, palabra: &palabra)

        }
    }

    /*
    func getPlayersByName(name: String, completion: @escaping([Data]) -> Void) {
        dataTask?.cancel()
            
        if var urlComponents = URLComponents(string: BASE_URL + "players/search/\(name)?api_token=\(API_TOKEN)") {

            guard let url = urlComponents.url else {
                return
            }
          
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in defer {
              self?.dataTask = nil
            }
            
            if let _ = error {
              //print(e.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                let outputStr  = String(data: data, encoding: String.Encoding.utf8) as! String
                
                do {
                    let json = try JSON(data: data)
                    let jsonData = json["data"]
                    //print(jsonData.rawString())
                    let players: [Data] = try JSONDecoder().decode([Data].self, from: (jsonData.rawString()?.data(using: .utf8))!)
                    if(players.count > 0) {
                        completion(players)
                    }

                } catch {
                    print(error.localizedDescription)
                }

            }
          }
            dataTask?.resume()
        }
    }
    
    func getImages() {

        // Peticion al servidor, json model
        NetworkManager.sharedIntance.manager.request(API.BASE_URL + "getImages", method: .post, parameters: self.getParams()).responseString {
            response in
            
            var jsonResponse: JSON = [:]
            do {

            if try self.checkCommonErrors(response, json: &jsonResponse) {
                
                let decoder = JSONDecoder()
                    let data: ImageResponse = try decoder.decode(ImageResponse.self, from: response.data!)
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "ALL_IMAGES"), object: nil, userInfo: ["imageresponse": data])

                
                //var palabra: Palabras = Palabras()
                //self.getData(json: jsonResponse, palabra: &palabra)
                
            }
            } catch _ {
                print("Error")
            }
        }
    }
    
    func getPlayerById(id: Int, completion: @escaping(Data) -> Void) {
        dataTask?.cancel()
            
        if var urlComponents = URLComponents(string: BASE_URL + "players/\(id)?api_token=\(API_TOKEN)") {

            guard let url = urlComponents.url else {
                return
            }
          
            print(url)
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in defer {
              self?.dataTask = nil
            }

            let outputStr  = String(data: data!, encoding: String.Encoding.utf8) as! String
            print(outputStr)

            if let _ = error {
              //print(e.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                do {
                    let json = try JSON(data: data)
                    let jsonData = json["data"]
                    let player: Data = try JSONDecoder().decode(Data.self, from: (jsonData.rawString()?.data(using: .utf8))!)
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
