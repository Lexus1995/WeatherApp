//
//  ViewController.swift
//  WeatherApp
//
//  Created by  Aliaksei on 10.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var searchLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var searchTextField: UITextField!
    
    private var searchResult: [SearchResult] = []
    private var weatherResult: WeatherResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }
    
    @IBAction func buttonPressed() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.hidesWhenStopped = true
        searchLabel.text = ""
        NetworkManager.shared.searchCities(from: searchURL + (searchTextField?.text ?? "") ) { searchResult in
            self.searchResult = searchResult
            for number in 0..<self.searchResult.count {
                NetworkManager.shared.fetchTemperature(from: cityURL + String(searchResult[number].woeid ?? 0) ) { weatherResult in
                    self.weatherResult = weatherResult
                    DispatchQueue.main.async {
                        for number in 0..<self.searchResult.count {
                            self.searchLabel.text? += "\n\(self.searchResult[number].title ?? "") \(self.weatherResult?.consolidatedWeather.first?.theTemp ?? 0.0)C"
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            }
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "Unknown location. Please try to write another location",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }        
}

