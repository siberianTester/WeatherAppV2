//
//  Extension + UIView.swift
//  WeatherApp
//
//  Created by Yaroslav Malygin on 30.11.2024.
//

import UIKit

extension UIView {
    func setGradient(weatherCode: Int?) {
        
        var gradientColors: [UIColor] {
            print(weatherCode ?? "")
            switch weatherCode {
            case 113: // Ясно
                return [UIColor.blue, UIColor.white]
            case 116, 119, 122: // Облачно
                return [UIColor.gray, UIColor.blue]
            case 143, 248, 260: // Туман
                return [UIColor.gray, UIColor.white]
            case 176, 185, 200, 266, 281, 296, 308: // Дождь
                return [UIColor.blue, UIColor.gray]
            case 179, 182, 227, 230, 317, 326, 332: // Снег
                return [UIColor.systemIndigo, UIColor.gray]
            default: // Прочие погодные условия
                return [UIColor.black, UIColor.gray]
            }
        }
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = gradientColors.map { $0.cgColor }
        gradient.locations = [0.0, 1.2]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        layer.insertSublayer(gradient, at: 0)
        gradient.frame = bounds
    }
}
