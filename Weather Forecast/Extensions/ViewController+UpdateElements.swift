//
//  ViewController+UpdateElements.swift
//  Weather Forecast
//
//  Created by Алексей Баканин on 29.10.2020.
//

import Foundation
import UIKit

extension WeatherViewController {
    
    func updateUserInterfaceWith(weather: MainWeather) {
        DispatchQueue.main.async {
            self.mainCurretTempLabel.text =
                "\(weather.currentTempString) °"
            self.mainCityLabel.text = weather.city
            self.mainWeatherIcon.image = UIImage(systemName: weather.systemIconNameString)
            self.feelsLikeLabel.text = "Ощущается как \(weather.feelsLikeString) °"
            self.windLabel.text = "\(weather.wind) м/с"
            self.pressureLabel.text = "\(weather.pressureInMmHg) мм рт. ст."
            self.humidityLabel.text = "\(weather.humidity) %"
            for (timeLabel, time) in zip(self.timeLabels, weather.timeFormatted) {
                timeLabel.text = time
            }
            for (bytimeWeather, timeTemp) in zip(self.byTimeWeatherTemps, weather.byTimeTempString) {
                bytimeWeather.text = "\(timeTemp) °"
            }
            for (icon, code) in zip(self.byTimeWeatherIcons, weather.byTimeIconsNameString) {
                icon.image = UIImage(systemName: code)
            }
            for i in interval.indices {
                self.daysForecast.append(DayForecast(date: "\(weather.calendarDay[i]) \(weather.monthName[i])", dayOfTheWeek: weather.dayOfTheWeekStringRU[i], dayForecastIcon: UIImage(systemName: weather.dayForecastIconImageName[i])!, dayTemp: weather.dayTempString[i], feelsLikeDayTemp: weather.feelsLikeDayTempString[i], iconCode: weather.dayForecastIcon[i]))
            }
        }
    }
    
    func setImagesForIcons() {
        mainWeatherIcon.image = UIImage(systemName: "questionmark.circle")
        
        windImage.image = UIImage(systemName: "wind")
        pressureImage.image = UIImage(systemName: "speedometer")
        humidityImage.image = UIImage(systemName: "drop")
        
        dayByDayTableView.layer.cornerRadius = dayByDayTableView.frame.size.height / 30
    }
    
}
