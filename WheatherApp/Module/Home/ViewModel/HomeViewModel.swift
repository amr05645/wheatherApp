//
//  HomeViewModel.swift
//  WheatherApp
//
//  Created by Amr Hassan on 28/12/2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    //MARK: - Properties
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    
    @Published var  forcastDays: [WheatherViewModel] = []
    @Published var appError: AppError?
    var cityName: String = ""
    let locationManager = LocationManager()
    
    var userLocation: String {
        let latitude = "\(locationManager.currentLocation?.coordinate.latitude ?? 51.5072)"
        let longitude = "\(locationManager.currentLocation?.coordinate.longitude ?? 0.1276)"
        return "\(latitude),\(longitude)"
    }
        
    //MARK: - Api Calling
    func getWeatherForecast(for location: String) {
        let apiService = APIService.shared
        
        apiService.getJSON(urlString: "\(Constants.apiBaseUrl)/forecast.json?key=\(Constants.apiKey)&q=\(location)&days=7&aqi=no&alerts=no",
                           dateDecodingStrategy: .secondsSince1970) { (result: Result<WheatherModel,APIService.APIError>) in
            switch result {
            case .success(let wheather):
                DispatchQueue.main.async {
                    self.forcastDays = wheather.forecast.forecastday.map({ WheatherViewModel(forcastDay: $0)})
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    self.appError = AppError(errorString: errorString)
                    print(errorString)
                }
            }
        }
    }
    
}
