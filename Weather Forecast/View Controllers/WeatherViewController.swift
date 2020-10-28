//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Алексей Баканин on 23.10.2020.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var mainWeatherIcon: UIImageView!
    @IBOutlet weak var mainCurretTempLabel: UILabel!
    @IBOutlet weak var mainCityLabel: UILabel!
    
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    @IBOutlet weak var windImage: UIImageView!
    @IBOutlet weak var pressureImage: UIImageView!
    @IBOutlet weak var humidityImage: UIImageView!
    
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet var timeLabels: [UILabel]!
    @IBOutlet var byTimeWeatherIcons: [UIImageView]!
    @IBOutlet var byTimeWeatherTemps: [UILabel]!
    
    @IBOutlet weak var dayByDayTableView: UITableView!
    
    var networkWeatherManager = NetworkWeatherManager()
    
    var daysForecast: [DayForecast] = [DayForecast(date: "23 октября", dayOfTheWeek: "Понедельник", dayForecastIcon: UIImage(systemName: "cloud.fill")!, dayTemp: "7 °", feelsLikeDayTemp: "7 °")]
        
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyHundredMeters
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkWeatherManager.onCompletion = {
            [weak self] mainWeather in
            guard let self = self else { return }
            self.updateUserInterfaceWith(weather: mainWeather)
        }
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        
        setImagesForIcons()
    }
    
    @IBAction func forecastByLocation(_ sender: UIButton) {
        networkWeatherManager.onCompletion = {
            [weak self] mainWeather in
            guard let self = self else { return }
            self.updateUserInterfaceWith(weather: mainWeather)
        }
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
    
    @IBAction func findForecastInCity(_ sender: UIButton) {
        findCityForecastAlertController(title: "Введите название города (на английском)", message: nil, style: .alert)
        { [unowned self] city in
            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .city(city: city))
        }
    }
    
    private func setImagesForIcons() {
        mainWeatherIcon.image = UIImage(systemName: "questionmark.circle")
        
        windImage.image = UIImage(systemName: "wind")
        pressureImage.image = UIImage(systemName: "speedometer")
        
        dayByDayTableView.layer.cornerRadius = dayByDayTableView.frame.size.height / 30
        
    }
    
    private func updateUserInterfaceWith(weather: MainWeather) {
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
//          self.daysForecast.append(DayForecast(date: weather.date, dayOfTheWeek: weather.dayOfTheWeekStringRU, dayForecastIcon: UIImage(systemName: weather.dayForecastIconImageName)!, dayTemp: weather.dayTempString, feelsLikeDayTemp: weather.feelsLikeDayTempString))
            
        }
    }
}
