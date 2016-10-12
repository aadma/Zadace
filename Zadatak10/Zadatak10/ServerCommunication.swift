//
//  ServerCommunication.swift
//  Zadatak10
//
//  Created by admir WIP on 12/10/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class ServerCommunication: NSObject {

    func refreshUsers(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        URLSession.shared.dataTask(with: url) { (data:Data?
            , response: URLResponse?, error: Error?) in
            
            if let error = error{
                print(error)
            }
            else{
                do{
                    Users.shared.users = [User]()
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                    for jsonObj in json{
                        let user = User()
                        if let name = jsonObj["name"] as? String{
                            user.name = name
                        }
                        if let email = jsonObj["email"] as? String{
                            user.email = email
                        }
                        if let addressObj = jsonObj["address"] as? [String: AnyObject]{
                            let address = Address()
                            user.address = address
                            if let city = addressObj["city"] as? String{
                                address.city = city
                            }
                            if let street = addressObj["street"] as? String{
                                address.street = street
                            }
                            if let geoObj = addressObj["geo"] as? [String: AnyObject]{
                                let geo = Geo()
                                address.geo = geo
                                if let lat = geoObj["lat"] as? String{
                                    geo.lat = lat
                                }
                                if let lng = geoObj["lng"] as? String{
                                    geo.lng = lng
                                }
                            }
                        }
                        if let companyObj = jsonObj["company"] as? [String: AnyObject]{
                            let company = Company()
                            user.company = company
                            if let coName = companyObj["name"] as? String{
                                company.name = coName
                            }
                            if let catchPhrase = companyObj["catchPhrase"] as? String{
                                company.catchPhrase = catchPhrase
                            }
                            if let bs = companyObj["bs"] as? String{
                                company.bs = bs
                            }
                        }
                        Users.shared.users?.append(user)
                       
                    }
                    
                    DispatchQueue.main.sync {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UsersRefreshed"), object: nil)
                    }

                }catch{
                    print(error)
                }
            }
            }.resume()

    }
}
