//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import UIKit
final class ForecastCell: UICollectionViewCell {
    static let indetifier = String(describing: ForecastCell.self)
    private lazy var dateLabel = DefaultLabel(font: .systemFont(ofSize: 14, weight: .bold))
    private lazy var timeLabel = DefaultLabel()
    private lazy var iconView = DefaultImageView()
    private lazy var tempLabel = DefaultLabel()
    
    var cellViewModel: ForecastViewModel? {
        didSet {
            dateLabel.text = cellViewModel?.date
            timeLabel.text = cellViewModel?.time
            tempLabel.text = cellViewModel?.temp
            Task {
                self.iconView.image = await cellViewModel?.getIcon()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addView(dateLabel)
        addView(timeLabel)
        addView(tempLabel)
        addView(iconView)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor),
            dateLabel.leftAnchor.constraint(equalTo: leftAnchor),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            timeLabel.leftAnchor.constraint(equalTo: leftAnchor),
            timeLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            tempLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            tempLabel.leftAnchor.constraint(equalTo: leftAnchor),
            tempLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            iconView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            iconView.bottomAnchor.constraint(equalTo: tempLabel.topAnchor),
            iconView.leftAnchor.constraint(equalTo: leftAnchor),
            iconView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
