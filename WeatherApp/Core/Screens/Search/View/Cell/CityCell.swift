//
//  CityCell.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import UIKit
final class CityCell: UITableViewCell {
    static let identifier = String(describing: CityCell.self)
    private lazy var cityName = DefaultLabel(font: .systemFont(ofSize: 15, weight: .regular))
    var cellViewModel: CityCellViewModel? {
        didSet {
            cityName.text = cellViewModel?.cityName
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addView(cityName)
        NSLayoutConstraint.activate([
            cityName.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cityName.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            cityName.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            cityName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
