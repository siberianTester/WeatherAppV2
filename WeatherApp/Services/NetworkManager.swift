//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Yaroslav Malygin on 01.12.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let accessKey = "b3a30d63fa388c5b3ff84313adac4395"

    func createWeatherURL(for city: String) -> URL? {
        let urlString = "https://api.weatherstack.com/current?access_key=\(accessKey)&query=\(city)"
        return URL(string: urlString)
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Ошибка запроса изображения: \(error.localizedDescription)")
                completion(.failure(.noData))
                return
            }
            
            guard let data = data else {
                print("Нет данных изображения")
                completion(.failure(.noData))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }

    
    func fetchCurrentWeather<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weather = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(weather))
                }
                print(weather)
            } catch {
                completion(.failure(.decodingError))
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    private init() {}
}
