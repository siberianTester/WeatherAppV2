//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yaroslav Malygin on 27.11.2024.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var weatherDescription: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var weatherParametersLabel: UILabel!
    
    //MARK: Private properties
    private var weather: Weather?
    private let networkManager = NetworkManager.shared
    var city: String? // Выбранный город
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let city = city {
            fetchWeather(for: city)
        }
        cityLabel.text = ""
        countryLabel.text = ""
        temperatureLabel.text = ""
        weatherDescription.text = ""
        weatherParametersLabel.text = ""
    }
    
    // MARK: - Private methods
    private func fetchWeather(for city: String) {
        guard let url = networkManager.createWeatherURL(for: city) else {
            print("Некорректный URL для города \(city)")
            return
        }

        networkManager.fetchCurrentWeather(Weather.self, from: url) { [weak self] result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self?.view.setGradient(weatherCode: weather.current.weatherCode)
                    self?.cityLabel.text = "\(weather.location.region),"
                    self?.countryLabel.text = weather.location.country
                    self?.temperatureLabel.text = "\(weather.current.temperature) °С"
                    self?.weatherDescription.text = weather.current.weatherDescriptions.first
                    self?.fetchImage(from: weather.current.weatherIcons.first)
                    self?.weatherParametersLabel.text = weather.current.weatherParameters
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchImage(from url: URL?) {
        guard let iconURL = url else {
            print("URL для иконки отсутствует")
            return
        }
        
        networkManager.fetchImage(from: iconURL) { [weak self] result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self?.weatherImage.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print("Ошибка загрузки изображения: \(error)")
            }
        }
    }
}

