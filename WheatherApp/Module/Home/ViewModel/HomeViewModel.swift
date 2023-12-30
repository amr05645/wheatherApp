//
//  HomeViewModel.swift
//  WheatherApp
//
//  Created by Amr Hassan on 28/12/2023.
//

import CoreLocation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    //MARK: - Properties
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    @Published var forcastDays: [WheatherViewModel] = []
    @Published var appError: AppError?
    @Published var isLoading: Bool = false
    var cityName: String = ""
    let locationManager = LocationManager()
    
    var userLocation: String {
        let latitude = "\(locationManager.currentLocation?.coordinate.latitude ?? 51.5072)"
        let longitude = "\(locationManager.currentLocation?.coordinate.longitude ?? 0.1276)"
        return "\(latitude),\(longitude)"
    }
    
    //MARK: - Api Calling
    func getWeatherForecast(for location: String) {
        UIApplication.shared.endEditing()
        isLoading = true
        let apiService = APIService.shared
        
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.appError = AppError(errorString: error.localizedDescription)
                    print(error.localizedDescription)
                }
                
            }
            if let city = placemarks?.first?.subAdministrativeArea {
                DispatchQueue.main.async {
                    self.cityName = city
                    print("city is",city)
                }
            }
            
            apiService.getJSON(urlString: "\(Constants.apiBaseUrl)/forecast.json?key=\(Constants.apiKey)&q=\(location)&days=7&aqi=no&alerts=no",
                               dateDecodingStrategy: .secondsSince1970) { (result: Result<WheatherModel,APIService.APIError>) in
                switch result {
                case .success(let wheather):
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.forcastDays = wheather.forecast.forecastday.map({ WheatherViewModel(forcastDay: $0)})
                    }
                case .failure(let apiError):
                    switch apiError {
                    case .error(let errorString):
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.appError = AppError(errorString: errorString)
                            print(errorString)
                        }
                    }
                }
            }
        }
    }
}
