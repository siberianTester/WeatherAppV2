//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yaroslav Malygin on 27.11.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeather()
    }
    
    private func fetchWeather() {
        URLSession.shared.dataTask(with: DataStore.shared.urlWeather) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                print(weather)
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}

