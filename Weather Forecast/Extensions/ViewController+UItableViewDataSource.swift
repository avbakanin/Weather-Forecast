//
//  ViewController+UItableViewDataSource.swift
//  Weather Forecast
//
//  Created by Алексей Баканин on 24.10.2020.
//

import Foundation
import UIKit

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayByDayForecastCell", for: indexPath) as! DayByDayForecastTableViewCell
        
        let dayForecast = daysForecast[indexPath.row]
        
        cell.set(date: dayForecast)
        
        return cell
    }
    
}
