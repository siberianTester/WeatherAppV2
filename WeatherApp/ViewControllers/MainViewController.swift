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
    case LosAngeles
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
        case .LosAngeles:
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeather",
           let destinationVC = segue.destination as? WeatherViewController,
           let indexPath = collectionView.indexPathsForSelectedItems?.first {
            destinationVC.city = cities[indexPath.item].cityName
        }
    }
}
