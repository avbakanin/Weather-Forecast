//
//  MainWeatherModel.swift
//  Weather Forecast
//
//  Created by Алексей Баканин on 23.10.2020.
//

import Foundation
import UIKit

struct MainWeather {
    
    private func getTime(fromDate date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm"
        
        guard let date = dateFormatterGet.date(from: date)
        else { return "There was an error decoding the string" }
        return dateFormatterPrint.string(from: date)
    }
    
    private func getNameOfTheDay(fromDate date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE"
        
        guard let date = dateFormatterGet.date(from: date)
        else { return "There was an error decoding the string" }
        return dateFormatterPrint.string(from: date)
    }
    
    let currentTemp: Double
    var currentTempString: String {
        return String(format: "%.1f", currentTemp)
    }
    
    var byTimeTemp: [Double] = []
    var byTimeTempString: [String] {
        var byTimeTempStringArray: [String] = []
        for i in byTimeTemp.indices {
            byTimeTempStringArray.append(String(format: "%.0f", byTimeTemp[i]))
        }
        return byTimeTempStringArray
    }
    
    var timeForecast: [String] = []
    var timeFormatted: [String] {
        var timeFormattedArray: [String] = []
        for i in timeForecast.indices {
            timeFormattedArray.append(getTime(fromDate: self.timeForecast[i]))
        }
        return timeFormattedArray
    }
    
    let city: String
    
    var byTimeConditionCodes: [Int] = []
    var byTimeIconsNameString: [String] {
        var byTimeIconsNameArray: [String] = []
        for i in byTimeConditionCodes.indices {
            switch byTimeConditionCodes[i] {
            case 200...232: byTimeIconsNameArray.append("cloud.bolt.rain.fill")
            case 300...321: byTimeIconsNameArray.append("cloud.drizzle.fill")
            case 500...531: byTimeIconsNameArray.append("cloud.rain.fill")
            case 600...622: byTimeIconsNameArray.append("cloud.snow.fill")
            case 700...781: byTimeIconsNameArray.append("smoke.fill")
            case 800: byTimeIconsNameArray.append("sun.min.fill")
            case 801...804: byTimeIconsNameArray.append("cloud.fill")
            default: break
            }
        }
        return byTimeIconsNameArray
    }
    
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 700...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return ""
        }
    }
    
    let feelsLike: Double
    var feelsLikeString: String {
        return String(format: "%.1f", feelsLike)
    }
    
    let wind: Double
    
    let pressure: Int
    var pressureInMmHg: String {
        let pressureChanched = Double(pressure) / 1.333
        return String(format: "%.0f", pressureChanched)
    }
    
    let humidity: Int
    
    let date: String
    
    let fullDate: String
    var dayOfTheWeekEN: String {
        getNameOfTheDay(fromDate: fullDate)
    }
    var dayOfTheWeekStringRU: String {
        switch dayOfTheWeekEN {
        case "Sunday": return "Воскресенье"
        case "Monday": return "Понедельник"
        case "Tuesday": return "Вторник"
        case "Wednesday": return "Среда"
        case "Thursday": return "Четверг"
        case "Friday": return "Пятница"
        case "Saturday": return "Суббота"
        default: return ""
        }
    }
    
    let dayForecastIcon: Int
    var dayForecastIconImageName: String {
        switch dayForecastIcon {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 700...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return ""
        }
    }
    
    let dayTemp: Double
    var dayTempString: String {
        return String(format: "%.0f", dayTemp)
    }
    
    let feelsLikeDayTemp: Double
    var feelsLikeDayTempString: String {
        return String(format: "%.0f", feelsLikeDayTemp)
    }
    
    init?(weatherForecast: WeatherForecast) {
        currentTemp = weatherForecast.list.first?.main.temp ?? 0
        city = weatherForecast.city.name
        conditionCode = weatherForecast.list.first?.weather.first?.id ?? 0
        feelsLike = weatherForecast.list.first?.main.feelsLike ?? 0
        wind = weatherForecast.list.first?.wind.speed ?? 0
        pressure = weatherForecast.list.first?.main.pressure ?? 0
        humidity = weatherForecast.list.first?.main.humidity ?? 0
        for i in times {
            byTimeTemp.append(weatherForecast.list[i].main.temp)
        }
        for i in times {
            timeForecast.append(weatherForecast.list[i].dtTxt)
        }
        for i in times {
            guard let weatherId = weatherForecast.list[i].weather.first?.id else { return nil }
            byTimeConditionCodes.append(weatherId)
        }
        date = weatherForecast.list[6].dtTxt
        fullDate = weatherForecast.list.first?.dtTxt ?? ""
        dayForecastIcon = weatherForecast.list.first?.weather.first?.id ?? 0
        dayTemp = weatherForecast.list.first?.main.temp ?? 0
        feelsLikeDayTemp = weatherForecast.list.first?.main.feelsLike ?? 0
    }
}
