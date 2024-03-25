//
//  DefaultStackView.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import UIKit
final class DefaultStackView: UIStackView {
    init(subview: [UIView], distribution: UIStackView.Distribution = .fillProportionally) {
        super.init(frame: .zero)
        subview.forEach { addArrangedSubview($0) }
        spacing = 2
        axis = .vertical
        self.distribution = distribution
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
