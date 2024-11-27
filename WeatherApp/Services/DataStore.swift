//
//  DataStore.swift
//  WeatherApp
//
//  Created by Yaroslav Malygin on 27.11.2024.
//

import Foundation

final class DataStore {
    
    static let shared = DataStore()
    
    private let accessKey = "0429ead64968b92873a31df7dbd3ba30"
    private let city = "Moscow"
    
    var urlWeather: URL {
        URL(string: "https://api.weatherstack.com/current?access_key=\(accessKey)&query=\(city)")!
    }
    
    private init() {}
}
