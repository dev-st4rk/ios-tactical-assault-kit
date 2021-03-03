//
//  MapViewModel.swift
//  ITAK
//
//  Created by Henrique Gonçalves Lourenço Silva on 02/03/21.
//

import SwiftUI
import MapKit
import CoreLocation

//All Map Data goes here

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    @Published var mapView = MKMapView();
    
    //Region
    @Published var region : MKCoordinateRegion!
    //Based on location it will set up
    
    //Alert
    @Published var permissionDenied = false
    
    //Map Type
    @Published var mapType : MKMapType = .standard
    
    //Search Text
    @Published var searchTxt = ""
    
    //Searched Places
    @Published var places : [Place] = []
    
    //Updating Map Type
    func updateMapType(){
        if mapType == .standard{
            mapType = .hybrid
            mapView.mapType = mapType
        }
        else
        {
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    //Focus Location
    
    func focusLocation(){
        
        guard let _ = region else{return}
        
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
    }
    
    //Searching Places
    
    func searchQuery(){
        
        places.removeAll()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTxt
        
        //Fetch
        
        MKLocalSearch(request: request).start { (response, _) in
            guard let result = response else{return}
            
            self.places = result.mapItems.compactMap({ (item) -> Place? in
                return Place(place: item.placemark)
            })
            
        }
    }
    
    //Pick search result
    
    func selectPlace(place: Place){
        
        //Showing pin on map
        searchTxt = ""
        
        guard let coordinate = place.place.location?.coordinate else{return}
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.place.name ?? "No Name"
        
        //Removing all old ones
        
        mapView.removeAnnotations(mapView.annotations)
        
        mapView.addAnnotation(pointAnnotation)
        
        //Moving map to the location
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
        
    }
    
//====================================================================================================
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            //Checking Permissions
        
        switch manager.authorizationStatus {
        case .denied:
            //Alert
            permissionDenied.toggle()
        
        case .notDetermined:
            //Requesting
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            //If permission given
            manager.requestLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    //Getting Soldier Region
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        //Updating Map
        
        self.mapView.setRegion(self.region, animated: true)
        
        //Smooth Animations
        
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
    
}
