//
//  NetworkWeatherManager.swift
//  Weather Forecast
//
//  Created by Алексей Баканин on 23.10.2020.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    enum RequestType {
        case city(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    var onCompletion: ((MainWeather) -> Void)?
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        
        switch requestType {
        case .city(let city):
            urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        }
        
        performeReauest(withUrlString: urlString)
    }
    
    fileprivate func performeReauest(withUrlString urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let getData = data else { return }
            guard let mainWeather = self.parseJson(withData: getData) else { return }
            self.onCompletion?(mainWeather)
        }
        task.resume()
    }
    
    fileprivate func parseJson(withData data: Data) -> MainWeather? {
        let decoder = JSONDecoder()
        do {
            let weatherForecast = try decoder.decode(WeatherForecast.self, from: data)
            guard let mainWeather = MainWeather(weatherForecast: weatherForecast) else { return nil }
            return mainWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
