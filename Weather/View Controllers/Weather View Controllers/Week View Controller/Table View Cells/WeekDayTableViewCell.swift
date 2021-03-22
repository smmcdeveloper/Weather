//
//  WeekDayTableViewCell.swift
//  Weather
//
//  Created by SMMC on 20/03/2021.
//

import UIKit

class WeekDayTableViewCell: UITableViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    @IBOutlet var dayLabel: UILabel! {
        didSet {
            dayLabel.textColor = UIColor.baseTextColor
            dayLabel.font = UIFont.Weather.heavyLarge
        }
    }
    
    @IBOutlet var dateLabel: UILabel! {
        didSet {
            dateLabel.textColor = .black
            dateLabel.font = UIFont.Weather.lightRegular
        }
    }
    
    @IBOutlet var windSpeedLabel: UILabel! {
        didSet {
            windSpeedLabel.textColor = .black
            windSpeedLabel.font = UIFont.Weather.lightSmall
        }
    }
    
    @IBOutlet var temperatureLabel: UILabel! {
        didSet {
            temperatureLabel.textColor = .black
            temperatureLabel.font = UIFont.Weather.lightSmall
        }
    }
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = UIColor.baseTintColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    func configure(with representable: WeekDayRepresentable) {
        dayLabel.text = representable.day
        dateLabel.text = representable.date
        iconImageView.image = representable.image
        windSpeedLabel.text = representable.windSpeed
        temperatureLabel.text = representable.temperature
    }
}
