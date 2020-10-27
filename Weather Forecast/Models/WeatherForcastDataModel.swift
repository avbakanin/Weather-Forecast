//
//  DayModel.swift
//  Weather Forecast
//
//  Created by Алексей Баканин on 23.10.2020.
//

import Foundation

struct WeatherForecast: Codable {
    let list: [List]
    let city: City
}

struct City: Codable {
    let name: String
}

struct List: Codable {
    let main: MainClass
    let weather: [Weather]
    let wind: Wind
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case main, weather, wind
        case dtTxt = "dt_txt"
    }
}

struct MainClass: Codable {
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int
}

struct Wind: Codable {
    let speed: Double
}
