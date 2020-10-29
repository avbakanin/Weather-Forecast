//
//  ViewController+UItableViewDataSource.swift
//  Weather Forecast
//
//  Created by Алексей Баканин on 24.10.2020.


import Foundation
import UIKit

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayByDayCell", for: indexPath) as! DayByDayCell
        
        let dayForecast = daysForecast[indexPath.row]
        
        cell.set(date: dayForecast)
        
        if cell.dayOfTheWeekLabel.text == "Воскресенье" {
            cell.dayOfTheWeekLabel.textColor = .red
        } else if cell.dayOfTheWeekLabel.text == "Суббота" {
            cell.dayOfTheWeekLabel.textColor = .red
        } else if indexPath.row == 0 {
            cell.dayOfTheWeekLabel.text = "Сегодня"
        } else if indexPath.row == 1 {
            cell.dayOfTheWeekLabel.text = "Завтра"
        }
        
        if let icon = Int(cell.iconCodeLabel.text!) {
            switch icon {
            case 200...232: cell.dayForecastIcon.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            case 300...321: cell.dayForecastIcon.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            case 500...531: cell.dayForecastIcon.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            case 600...622: cell.dayForecastIcon.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            case 700...781: cell.dayForecastIcon.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            case 800: cell.dayForecastIcon.tintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            case 801...804: cell.dayForecastIcon.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            default: break
            }}
        
        return cell
    }
}
