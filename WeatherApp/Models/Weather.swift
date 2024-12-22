//
//  Weather.swift
//  WeatherApp
//
//  Created by Yaroslav Malygin on 27.11.2024.
//

import Foundation

// MARK: - Location Struct
struct Location {
    let name: String
    let country: String
    
    init(locationData: [String: Any]) {
        name = locationData["name"] as? String ?? ""
        country = locationData["country"] as? String ?? ""
    }
    
    static func getLocation(from locations: Any) -> Location? {
        guard let locations = locations as? [String: Any] else { return nil }
        guard let locationData = locations["location"] as? [String: Any] else { return nil }
        
        return Location(locationData: locationData)
    }
}

// MARK: - Current Struct
struct Current {
    let observationTime: String
    let temperature: Int
    let weatherCode: Int
    let weatherIcons: [URL]
    let weatherDescriptions: [String]
    let windSpeed: Int
    let windDir: String
    let pressure: Int
    let humidity: Int
    let visibility: Int
    
    var weatherParameters: String {
        """
        Wind speed: \(String(windSpeed)) mph
        
        Wind direction: \(String(windDir))
        
        Pressure: \(String(pressure)) mb
        
        Humidity: \(String(humidity)) %
        
        Visibility: \(String(visibility)) miles
        
        Observation time: \(observationTime)
        """
    }
    
    init(currentData: [String: Any]) {
        observationTime = currentData["observation_time"] as? String ?? ""
        temperature = currentData["temperature"] as? Int ?? 0
        weatherCode = currentData["weather_code"] as? Int ?? 0
        
        if let icons = currentData["weather_icons"] as? [String] {
            weatherIcons = icons.compactMap { URL(string: $0) }
        } else { weatherIcons = [] }
        
        weatherDescriptions = currentData["weather_descriptions"] as? [String] ?? [""]
        windSpeed = currentData["wind_speed"] as? Int ?? 0
        windDir = currentData["wind_dir"] as? String ?? ""
        pressure = currentData["pressure"] as? Int ?? 0
        humidity = currentData["humidity"] as? Int ?? 0
        visibility = currentData["visibility"] as? Int ?? 0
    }
    
    static func getCurrentWeather(from currents: Any) -> Current? {
        guard let currents = currents as? [String: Any] else { return nil }
        guard let currentData = currents["current"] as? [String: Any] else { return nil }
        
        return Current(currentData: currentData)
    }
}
