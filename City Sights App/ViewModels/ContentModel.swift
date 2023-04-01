//
//  ContentModel.swift
//  City Sights App
//
//  Created by Bryan Huang on 3/23/23.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    override init() {
        
        // init method of NSObject
        super.init()
        
        // set content model as the delegate of the location manager
        locationManager.delegate = self
        
        // Request permission from the user
        locationManager.requestWhenInUseAuthorization()
        
        
    }
    
    // MARK: - Location Manager Delegate methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            
            // we have permission
            
            // TODO: start geolocating the user, after we get permission
            locationManager.startUpdatingLocation()
            
            
        }
        else if locationManager.authorizationStatus == .denied {
            // we don't have permission
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // gives us the location of the user
        let userLocation = locations.first
        
        if userLocation != nil {
            
            // we have the location
            // stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            
            // if we have the coordinate of the user, send into Yelp API
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
            
        }
        
    }
    
    // MARK: - yelp api methods
    
    func getBusinesses(category:String, location:CLLocation) {
        
        /*// Create URL
         let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
         let url = URL(string: urlString)
         */
        var urlComponents = URLComponents(string: Constants.apiUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        let url = urlComponents?.url
        
        if let url = url {
            // Create URL request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            // get URL session
            let session = URLSession.shared
            
            // Create Data tasks
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                // check that there isn't an error
                if error == nil {
                    
                    do {
                        // parse json
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        DispatchQueue.main.async {
                            // assign result to the appropriate property
                            switch category {
                            case Constants.sightsKey:
                                self.sights = result.businesses
                            case Constants.restaurantsKey:
                                self.sights = result.businesses
                            default:
                                break
                            }
                        }

                    }
                    catch {
                        print(error)
                    }

                }
                
            }
            
            // Start the Data tasks
            dataTask.resume()
            
            
        }
    }
    
}
