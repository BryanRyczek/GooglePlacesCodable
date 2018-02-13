//
//  ViewController.swift
//  GooglePlacesCodable
//
//  Created by Bryan Ryczek on 2/13/18.
//  Copyright © 2018 Bryan Ryczek. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    //networking
    lazy var googleClient: GoogleClientRequest = GoogleClient()
    //location
    var currentLocation: CLLocation = CLLocation(latitude: 42.361145, longitude: -71.057083)
    var locationName : String = "Starbucks"
    var searchRadius : Int = 2500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGoogleData(forLocation: currentLocation)
    }
}

//Networking calls
extension ViewController {
    func fetchGoogleData(forLocation: CLLocation) {
        //guard let location = currentLocation else { return }
        googleClient.getGooglePlacesData(forKeyword: "Starbucks", location: currentLocation, withinMeters: 2500) { (response) in
            
            self.printFirstFive(places: response.results)
            
        }
    }
    
    func printFirstFive(places: [Place]) {
        for place in places.prefix(5) {
            print("*******NEW PLACE********")
            let name = place.name
            let address = place.address
            let location = ("lat: \(place.geometry.location.latitude), lng: \(place.geometry.location.longitude)")
            guard let open = place.openingHours?.open  else {
                print("\(name) is located at \(address), \(location)")
                return
            }
            if open {
                print("\(name) is open, located at \(address), \(location)")
            } else {
                print("\(name) is closed, located at \(address), \(location)")
            }
        }
    }
}

