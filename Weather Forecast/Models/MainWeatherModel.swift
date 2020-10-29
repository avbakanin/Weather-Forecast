//
//  MainWeatherModel.swift
//  Weather Forecast
//
//  Created by Алексей Баканин on 23.10.2020.
//

import Foundation
import UIKit

struct MainWeather {
    
    private func getDate(fromDate date: String, formatter: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formatter
        
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
            timeFormattedArray.append(getDate(fromDate: self.timeForecast[i], formatter: "HH:mm"))
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
    
    var fullDate: [String] = []
    
    var calendarDay: [String] {
        var calendarDays: [String] = []
        for i in fullDate.indices{
            calendarDays.append(getDate(fromDate: fullDate[i], formatter: "dd"))
        }
        return calendarDays
    }
    
    var monthNumber: [String] {
        var monthesNumber: [String] = []
        for i in fullDate.indices {
            monthesNumber.append(getDate(fromDate: fullDate[i], formatter: "MM"))
        }
        return monthesNumber
    }
    
    var monthName: [String] {
        var monthesName: [String] = []
        for i in monthNumber.indices {
            switch monthNumber[i] {
            case "1": monthesName.append("января")
            case "2": monthesName.append("февраля")
            case "3": monthesName.append("марта")
            case "4": monthesName.append("апреля")
            case "5": monthesName.append("мая")
            case "6": monthesName.append("июня")
            case "7": monthesName.append("июля")
            case "8": monthesName.append("августа")
            case "9": monthesName.append("сентября")
            case "10": monthesName.append("октября")
            case "11": monthesName.append("ноября")
            case "12": monthesName.append("декабря")
            default:  monthesName.append("")
            }
        }
        return monthesName
    }
    
    var dayOfTheWeekEN: [String] {
        var daysOfTheWeek: [String] = []
        for i in fullDate.indices {
            daysOfTheWeek.append(getDate(fromDate: fullDate[i], formatter: "EEEE"))
        }
        return daysOfTheWeek
    }
    
    var dayOfTheWeekStringRU: [String] {
        var daysOfTheWeekString: [String] = []
        for i in dayOfTheWeekEN.indices{
            switch dayOfTheWeekEN[i] {
            case "Sunday": daysOfTheWeekString.append("Воскресенье")
            case "Monday": daysOfTheWeekString.append("Понедельник")
            case "Tuesday": daysOfTheWeekString.append("Вторник")
            case "Wednesday": daysOfTheWeekString.append("Среда")
            case "Thursday": daysOfTheWeekString.append("Четверг")
            case "Friday": daysOfTheWeekString.append("Пятница")
            case "Saturday": daysOfTheWeekString.append("Суббота")
            default: daysOfTheWeekString.append("")
            }
        }
        return daysOfTheWeekString
    }
    
    var dayForecastIcon: [Int] = []
    var dayForecastIconImageName: [String] {
        var daysForecastIconImageName: [String] = []
        for i in dayForecastIcon.indices{
            switch dayForecastIcon[i] {
            case 200...232: daysForecastIconImageName.append("cloud.bolt.rain.fill")
            case 300...321: daysForecastIconImageName.append("cloud.drizzle.fill")
            case 500...531: daysForecastIconImageName.append("cloud.rain.fill")
            case 600...622: daysForecastIconImageName.append("cloud.snow.fill")
            case 700...781: daysForecastIconImageName.append("smoke.fill")
            case 800: daysForecastIconImageName.append("sun.min.fill")
            case 801...804: daysForecastIconImageName.append("cloud.fill")
            default: daysForecastIconImageName.append("")
            }
        }
        return daysForecastIconImageName
    }
    
    var dayTemp: [Double] = []
    var dayTempString: [String] {
        var daysTempString: [String] = []
        for i in dayTemp.indices{
            daysTempString.append(String(format: "%.0f", dayTemp[i]))
        }
        return daysTempString
    }
    
    var feelsLikeDayTemp: [Double] = []
    var feelsLikeDayTempString: [String] {
        var feelsLikeDaysTempString: [String] = []
        for i in feelsLikeDayTemp.indices {
            feelsLikeDaysTempString.append(String(format: "%.0f", feelsLikeDayTemp[i]))
        }
        return feelsLikeDaysTempString
    }
    
    var daysWeatherForecast: [DayForecast] = []
    
    
    
    init?(weatherForecast: WeatherForecast) {
        currentTemp = weatherForecast.list.first?.main.temp ?? 0
        city = weatherForecast.city.name
        conditionCode = weatherForecast.list.first?.weather.first?.id ?? 0
        feelsLike = weatherForecast.list.first?.main.feelsLike ?? 0
        wind = weatherForecast.list.first?.wind.speed ?? 0
        pressure = weatherForecast.list.first?.main.pressure ?? 0
        humidity = weatherForecast.list.first?.main.humidity ?? 0
        for i in times {
            timeForecast.append(weatherForecast.list[i].dtTxt)
            byTimeTemp.append(weatherForecast.list[i].main.temp)
            guard let weatherId = weatherForecast.list[i].weather.first?.id else { return nil }
            byTimeConditionCodes.append(weatherId)
        }
        for i in interval {
            fullDate.append(weatherForecast.list[i].dtTxt)
            dayForecastIcon.append(weatherForecast.list[i].weather.first?.id ?? 0)
            dayTemp.append(weatherForecast.list[i].main.temp)
            feelsLikeDayTemp.append(weatherForecast.list[i].main.feelsLike)
        }
    }
}
