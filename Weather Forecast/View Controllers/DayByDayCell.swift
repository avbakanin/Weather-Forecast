//
//  DayByDayForecastTableViewCell.swift
//  Weather Forecast
//
//  Created by Алексей Баканин on 24.10.2020.
//

import UIKit

class DayByDayCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayOfTheWeekLabel: UILabel!
    @IBOutlet weak var dayForecastIcon: UIImageView!
    @IBOutlet weak var dayTemp: UILabel!
    @IBOutlet weak var feelsLikeDayTemp: UILabel!
    @IBOutlet weak var iconCodeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(date: DayForecast) {
        
            self.dateLabel.text = date.date
            self.dayOfTheWeekLabel.text = date.dayOfTheWeek
            self.dayForecastIcon.image = date.dayForecastIcon
            self.dayTemp.text = date.dayTemp
            self.feelsLikeDayTemp.text = date.feelsLikeDayTemp
            self.iconCodeLabel.text = String(date.iconCode)
    }
}
