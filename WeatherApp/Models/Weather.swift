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
    let timezone_id: String
    let localtime: String
    let localtime_epoch: Int
    let utc_offset: String
}

// MARK: - Current Struct
struct Current: Decodable {
    let observation_time: String
    let temperature: Int
    let weather_code: Int
    let weather_icons: [URL]
    let weather_descriptions: [String]
    let wind_speed: Int
    let wind_degree: Int
    let wind_dir: String
    let pressure: Int
    let precip: Int
    let humidity: Int
    let cloudcover: Int
    let feelslike: Int
    let uv_index: Int
    let visibility: Int
    let is_day: String
}
