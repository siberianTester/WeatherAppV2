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
    private var locations: Location?
    private var currents: Current?
    private let networkManager = NetworkManager.shared
    private var activityIndicator: UIActivityIndicatorView?
    
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
        
        showLoadingIndicator()
        
        networkManager.fetchCurrentsData(from: url) { [unowned self] result in
            hideLoadingIndicator()
            switch result {
            case .success(let current):
                currents = current
                view.setGradient(weatherCode: current.weatherCode)
                temperatureLabel.text = "\(current.temperature) °C"
                weatherDescription.text = current.weatherDescriptions.first
                weatherParametersLabel.text = current.weatherParameters
                
                if let imageURL = current.weatherIcons.first {
                    fetchImage(from: imageURL)
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        networkManager.fetchLocationsData(from: url) { [unowned self] result in
            switch result {
            case .success(let location):
                locations = location
                cityLabel.text = location.name
                countryLabel.text = location.country
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchImage(from url: URL) {
        networkManager.fetchData(from: url) { [unowned self] result in
            switch result {
            case .success(let imageData):
                weatherImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func showLoadingIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.color = .white
        activityIndicator?.center = view.center
        activityIndicator?.startAnimating()
        if let indicator = activityIndicator {
            view.addSubview(indicator)
        }
    }
    
    private func hideLoadingIndicator() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
    }
}

