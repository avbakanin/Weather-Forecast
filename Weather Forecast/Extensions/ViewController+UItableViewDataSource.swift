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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayByDayCell", for: indexPath) as! DayByDayCell
        
        let dayForecast = daysForecast[indexPath.row]
        
        cell.set(date: dayForecast)        
        
        return cell
    }
    
}
