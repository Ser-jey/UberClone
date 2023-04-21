//
//  LocationSearchViewModel.swift
//  UberApp
//
//  Created by Сергей Кривошеев on 13.12.2022.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    // MARK: - Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation: UberLocation?
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var pickupTime: String?
    @Published var dropOffTime: String?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    // MARK: Lifecycle
    
    override init() {
        super.init()
         searchCompleter.delegate = self
         searchCompleter.queryFragment = queryFragment
         
    }
    
        // MARK: - Helpers
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchComplition: localSearch) { response, error in
            
            if let error = error {
                print("Location search failed with error: \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
        }
    }
    
    func locationSearch(forLocalSearchComplition localSearch: MKLocalSearchCompletion, completion: @escaping(MKLocalSearch.CompletionHandler)) {
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
        
    }
    
    func computeRidePrice(forType type: RideType) -> Double {
        guard let coordinate = selectedUberLocation?.coordinate else { return 0 }
        guard let userLocation = userLocation else { return 0 }
        
        let location = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let destination = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let tripDestinationInMeters = location.distance(from: destination)
        return type.computePrice(for: tripDestinationInMeters)
        
    }
    
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, complition: @escaping (MKRoute) -> Void ) {
        
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if let error = error {
                print("DEBUG: Failed to get directions with error \(error.localizedDescription)")
                return
            }
            guard let route = response?.routes.first else { return }
            self.configurePickUpAndDropOffTimes(with: route.expectedTravelTime)
            complition(route)
        }
    }
    
    func configurePickUpAndDropOffTimes(with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        pickupTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date().addingTimeInterval(expectedTravelTime))
    }
    
}

    

// - MARK: - MKLocalSearchCompleterDelegates
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
