//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Yaroslav Malygin on 01.12.2024.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let accessKey = "c3ff97d872240d16c55c07e0725fe592"
    
    func createWeatherURL(for city: String) -> URL? {
        let urlString = "https://api.weatherstack.com/current?access_key=\(accessKey)&query=\(city)"
        return URL(string: urlString)
    }
    
    func fetchLocationsData(from url: URL, completion: @escaping(Result<Location, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let location = Location.getLocation(from: value) else { return }
                    completion(.success(location))
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchCurrentsData(from url: URL, completion: @escaping(Result<Current, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let current = Current.getCurrentWeather(from: value) else { return }
                    completion(.success(current))
                    print(current.weatherIcons)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchData(from url: URL, completion: @escaping(Result<Data, AFError>) -> Void ) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    private init() {}
}
