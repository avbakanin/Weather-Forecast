//
//  ViewController+CLLocationDelegate.swift
//  Weather Forecast
//
//  Created by Алексей Баканин on 23.10.2020.
//

import Foundation
import CoreLocation

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkWeatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func displayForecastByLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        
        networkWeatherManager.onCompletion = {
            [weak self] mainWeather in
            guard let self = self else { return }
            self.updateUserInterfaceWith(weather: mainWeather)
        }
    }
}
