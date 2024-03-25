//
//  DefaultLoader.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import UIKit
final class DefaultLoader: UIImageView {
    var timer = Timer()
    
    init() {
        super.init(frame: .zero)
        image = UIImage(named: "logo")!
        contentMode = .scaleAspectFit
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseOut]) {
                self.transform = .init(scaleX: 10, y: 10)
            } completion: { _ in
                self.transform = .identity
            }
        }
    }
    deinit {
        timer.invalidate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
