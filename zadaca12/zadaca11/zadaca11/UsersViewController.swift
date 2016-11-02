//
//  UsersViewController.swift
//  zadaca11
//
//  Created by admir WIP on 18/10/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class UsersViewController: UIViewController, MKMapViewDelegate {
    
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [User]()
    var sortedUsersArray = [SortedUser]()
    var sorted = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        mapView.delegate = self
    }

    @IBAction func sendRequestForUsers(_ sender: AnyObject) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        URLSession.shared.dataTask(with: url) { (data:Data?
            , response: URLResponse?, error: Error?) in
            
            if let error = error{
                print(error)
            }
            else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String: AnyObject]]
                  self.users = [User]()
                    
                    for jsonObj in json{
                        let user = User()
                        if let name = jsonObj["name"] as? String{
                            user.name = name
                        }
                        if let username = jsonObj["username"] as? String{
                            user.username = username
                        }
                        if let phone = jsonObj["phone"] as? String{
                            user.phone = phone
                        }
                        if let website = jsonObj["website"] as? String{
                            user.website = website
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
                        self.users.append(user)
                        
                    }
                    DispatchQueue.main.sync {
                        self.putUsersOnMap()
                        self.tableView.reloadData()
                    }
                }catch{
                    print(error)
                }
            }
            }.resume()
        sorted = false
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "User"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            btn.addTarget(self, action: #selector(UsersViewController.displayUser), for: UIControlEvents.touchUpInside)
            annotationView!.rightCalloutAccessoryView = btn
        } else {
            annotationView!.annotation = annotation
            
        }
        return annotationView
    }

    
    func putUsersOnMap(){
        for user in users{
            let annotation = MKPointAnnotation()
            if let lat = Double((user.address?.geo?.lat)!), let lng = Double((user.address?.geo?.lng)!){
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                annotation.coordinate = coordinate
            }
            annotation.title = user.name
            if let street = user.address?.street, let city = user.address?.city{
                annotation.subtitle = street + ", " + city
            }
            mapView.addAnnotation(annotation)
        }
        showUsersLocation(user: users.first!)
    }
    
    
    func showUsersLocation(user: User){
        UserProfile.shared.userProfile = user
        let lat = user.address?.geo?.lat
        let lng = user.address?.geo?.lng
        let coordinate = CLLocationCoordinate2DMake(Double(lat!)!, Double(lng!)!)
        let span = MKCoordinateSpanMake(1, 1)
        let firstUserRegion = MKCoordinateRegionMake(coordinate, span)
        mapView.setRegion(firstUserRegion, animated: true)
    }
    
    func sortUsersByDistance(){
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func sort(_ sender: UIBarButtonItem) {
        guard users.count > 0 else{
            return
        }
        sortUsersByDistance()
    }
    
    func displayUser(){
        performSegue(withIdentifier: "showUserSegue", sender: self)
    }

    struct SortedUser{
        var name: String?
        var distanceFromUser: Double?
        var user: User?
    }
}

// MARK: TableView delegate and data source
extension UsersViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var user: User
        if sorted == false{
        user = users[indexPath.row]
        }else{
            user = sortedUsersArray[indexPath.row].user!
        }
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = (user.address?.street)! + ", " + (user.address?.city)!
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var user: User
        if sorted == false{
        user = users[indexPath.row]
        }else{
        user = sortedUsersArray[indexPath.row].user!
        }
        showUsersLocation(user: user)
    }
    
}

// MARK: LocationNanagerDelegate
extension UsersViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let myLocation: CLLocation = locations.last!
        var sortedUsers = [SortedUser]()
        for user in users{
            let lat = user.address?.geo?.lat
            let lng = user.address?.geo?.lng
            let userLocation = CLLocation(latitude: Double(lat!)!, longitude: Double(lng!)!)
            var userToSort = SortedUser()
            let name = user.name!
            let distance = myLocation.distance(from: userLocation)
            let userObj = user
            userToSort.name = name
            userToSort.distanceFromUser = distance
            userToSort.user = userObj
            sortedUsers.append(userToSort)
        }
        sortedUsers.sort(by: { $0.distanceFromUser! < $1.distanceFromUser! })
        for sUser in sortedUsers{
            print("\(sUser.name!)  is  \(sUser.distanceFromUser! / 1000) km away")
        }
        sortedUsersArray = sortedUsers
        sorted = true
        locationManager.stopUpdatingLocation()
        tableView.reloadData()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("user did enter \(region.identifier)")
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("user did exit \(region.identifier)")
    }
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("monitoring failed with error: \(error.localizedDescription)")
    }
    
}
