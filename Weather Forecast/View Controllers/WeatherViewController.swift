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
    
    @IBOutlet weak var reloadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var dayByDayTableView: UITableView!
    
    var networkWeatherManager = NetworkWeatherManager()
    
    var daysForecast: [DayForecast] = []
    
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
            
            DispatchQueue.main.async {
                self.activityViewDisplaying()
                self.dayByDayTableView.reloadData()
            }
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        
        setImagesForIcons()
    }
    
    @IBAction func forecastByLocation(_ sender: UIButton) {
        self.daysForecast = []
        self.setStartCondotionToViews()
        networkWeatherManager.onCompletion = {
            [weak self] mainWeather in
            guard let self = self else { return }
            self.updateUserInterfaceWith(weather: mainWeather)
            
            DispatchQueue.main.async {
                self.activityViewDisplaying()
                self.dayByDayTableView.reloadData()
            }
            
        }
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
    
    @IBAction func findForecastInCity(_ sender: UIButton) {
        findCityForecastAlertController(title: "Введите название города (на английском)", message: nil, style: .alert)
        { [unowned self] city in
            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .city(city: city))
            
            DispatchQueue.main.async {
                self.activityViewDisplaying()
                self.dayByDayTableView.reloadData()
            }
            
        }
    }
}

