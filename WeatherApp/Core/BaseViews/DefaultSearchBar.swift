//
//  DefaultSearchBar.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import UIKit
final class DefaultSearchBar: UISearchBar {
    init(placeholder: String) {
        super.init(frame: .zero)
        self.searchBarStyle = UISearchBar.Style.default
        self.searchTextField.textColor = .black
        self.placeholder = placeholder
        self.sizeToFit()
        self.barTintColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.isTranslucent = true
        self.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
