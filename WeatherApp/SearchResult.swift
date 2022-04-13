//
//  Weather.swift
//  WeatherApp
//
//  Created by  Aliaksei on 12.04.2022.
//

import Foundation

let searchURL = "https://www.metaweather.com/api/location/search/?query="

struct SearchResult: Decodable {
    let title: String?
    let location_type: String?
    let woeid: Int?
    let latt_long: String?
}

