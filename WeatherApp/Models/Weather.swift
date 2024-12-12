//
//  Weather.swift
//  WeatherApp
//
//  Created by Yaroslav Malygin on 27.11.2024.
//

import Foundation

// MARK: - Main Structs
struct Weather: Decodable {
    let request: Request
    let location: Location
    let current: Current
}

// MARK: - Request Struct
struct Request: Decodable {
    let type: String
    let query: String
    let language: String
    let unit: String
}

// MARK: - Location Struct
struct Location: Decodable {
    let name: String
    let country: String
    let region: String
    let lat: String
    let lon: String
    let timezoneId: String
    let localtime: String
    let localtimeEpoch: Int
    let utcOffset: String
}

// MARK: - Current Struct
struct Current: Decodable {
    let observationTime: String
    let temperature: Int
    let weatherCode: Int
    let weatherIcons: [URL]
    let weatherDescriptions: [String]
    let windSpeed: Int
    let windDegree: Int
    let windDir: String
    let pressure: Int
    let precip: Int
    let humidity: Int
    let cloudcover: Int
    let feelslike: Int
    let uvIndex: Int
    let visibility: Int
    let isDay: String
    
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
}
