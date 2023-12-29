//
//  ContentView.swift
//  WheatherApp
//
//  Created by Amr Hassan on 28/12/2023.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    @State var cityName: String
    @State var wheather: WheatherModel? = nil
    
    let locationManager = LocationManager()
    
    var userLocation: String {
        let latitude = "\(locationManager.currentLocation?.coordinate.latitude ?? 51.5072)"
        let longitude = "\(locationManager.currentLocation?.coordinate.longitude ?? 0.1276)"
        return "\(latitude),\(longitude)"
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter Location", text: $cityName)
                    Button {
                        getWeatherForecast(for: cityName)
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                    }
                }
                if let wheather {
                    List(wheather.forecast.forecastday, id: \.date) { day in
                        VStack(alignment: .leading) {
                            Text(day.date)
                                .fontWeight(.bold)
                            HStack(alignment: .center) {
                                Image(systemName: "hourglass")
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
                                
                                VStack(alignment: .leading) {
                                    Text(day.day.condition.text.capitalized)
                                    HStack {
                                        Text("Max: \(day.day.maxtempC, specifier: "%.0f")")
                                        Text("Min: \(day.day.mintempC, specifier: "%.0f")")
                                    }
                                    Text("Chance Of Rain: \(day.day.dailyChanceOfRain)")
                                    Text("Humidity: \(day.day.avghumidity)")
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                } else {
                    Spacer()
                }
            }
            .padding(.horizontal)
            .navigationTitle("Wheather App")
        }
    }
    
    func getWeatherForecast(for location: String) {
        let apiService = APIService.shared
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "E, MMM, d"
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {
                // Don't forget to use your own key
                apiService.getJSON(urlString: "https://api.weatherapi.com/v1/forecast.json?key=\(Constants.apiKey)&q=\(location)&days=7&aqi=no&alerts=no",
                                   dateDecodingStrategy: .secondsSince1970) { (result: Result<WheatherModel,APIService.APIError>) in
                    switch result {
                    case .success(let wheather):
                        self.wheather = wheather
                        //                        for day in wheather.forecast.forecastday {
                        //                            print("date :" ,day.date)
                        //                            print("   Max: ", day.day.maxtempC)
                        //                            print("   Min: ", day.day.mintempC)
                        //                            print("   Humidity: ", day.day.avghumidity)
                        ////                            print("   Description: ", day.weather[0].description)
                        ////                            print("   Clouds: ", day.clouds)
                        ////                            print("   pop: ", day.pop)
                        //                            print("   IconURL: ", day.day.condition.icon)
                        //                        }
                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            print(errorString)
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    HomeView(cityName: "")
}
