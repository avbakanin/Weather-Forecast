//
//  ViewController+AlertController.swift
//  Weather Forecast
//
//  Created by Алексей Баканин on 23.10.2020.
//

import Foundation
import UIKit

extension WeatherViewController {
    
    func findCityForecastAlertController(title: String?,
                                         message: String?,
                                         style: UIAlertController.Style,
                                         completionHandler: @escaping (String) -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.addTextField { (tf) in
            let cities = ["Moscow",
                          "Tula",
                          "Havana",
                          "Barcelona",
                          "London",
                          "New York",
                          "Los Angeles",
                          "Berlin",
                          "Magadan"]
            tf.placeholder = cities.randomElement()
        }
        
        let searchAction = UIAlertAction(title: "Найти", style: .default) { (action) in
            guard let textField = alert.textFields?.first else { return }
            guard let city = textField.text else { return }
            if city != "" {
                let cityName = city.split(separator: " ").joined(separator: "%20")
                completionHandler(cityName)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(searchAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
