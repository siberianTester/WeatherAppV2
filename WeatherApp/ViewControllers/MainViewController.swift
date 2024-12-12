//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Yaroslav Malygin on 09.12.2024.
//

import UIKit

enum Cities: CaseIterable {
    case SaintPetersburg
    case Omsk
    case Losangeles
    case Boston
    case Berlin
    case Novosibirsk
    case Tokyo

    
    var cityName: String {
        switch self {
        case .SaintPetersburg:
            return "Saint-Petersburg"
        case .Omsk:
            return "Omsk"
        case .Losangeles:
            return "Los-Angeles"
        case .Boston:
            return "Boston"
        case .Berlin:
            return "Berlin"
        case .Novosibirsk:
            return "Novosibirsk"
        case .Tokyo:
            return "Tokyo"
        }
    }
}

final class MainViewController: UICollectionViewController {
    
    private let cities = Cities.allCases
    private let networkManager = NetworkManager.shared
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cities.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cityAction", for: indexPath)
        guard let cell = cell as? CityActionCell else { return UICollectionViewCell() }
        cell.cityActionLabel.text = cities[indexPath.item].cityName
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCity = cities[indexPath.item].cityName
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let weatherVC = storyboard.instantiateViewController(withIdentifier: "showWeather") as? WeatherViewController {
            weatherVC.city = selectedCity
            navigationController?.pushViewController(weatherVC, animated: false)
        }
    }
}
