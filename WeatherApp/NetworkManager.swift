//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by  Aliaksei on 10.04.2022.
//

import Foundation

enum NteworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
        
    func searchCities(from url: String?, with completion: @escaping([SearchResult]) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let searchResult = try JSONDecoder().decode([SearchResult].self, from: data)
                DispatchQueue.main.async {
                    completion(searchResult)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchTemperature(from url: String?, with completion: @escaping(WeatherResult) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let weatherResult = try JSONDecoder().decode(WeatherResult.self, from: data)
                DispatchQueue.main.async {
                    completion(weatherResult)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
}

