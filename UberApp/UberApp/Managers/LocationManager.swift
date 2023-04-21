//
//  LocationManager.swift
//  UberApp
//
//  Created by Сергей Кривошеев on 04.12.2022.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    static let shared = LocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // Точность местоположения
        locationManager.requestWhenInUseAuthorization() // Запросить и проверить разрешения
        locationManager.startUpdatingLocation() // Начать обновлять данные по местоположению
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.userLocation = location.coordinate
        locationManager.stopUpdatingLocation()
    }
}
