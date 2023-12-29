//
//  ContentView.swift
//  WheatherApp
//
//  Created by Amr Hassan on 28/12/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    @State var cityName: String
    
    let locationManager = LocationManager()
    
    var userLocation: String {
        let latitude = "\(locationManager.currentLocation?.coordinate.latitude ?? 0)"
        let longitude = "\(locationManager.currentLocation?.coordinate.longitude ?? 0)"
        return "\(latitude),\(longitude)"
    }
    
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            TextField(
                "CityName",
                text: $cityName
            )
            .onSubmit {
                Task {
                    do {
                        await homeViewModel.fetchWheatherData(cityName)
                    }
                }
            }
        }
        .task {
            await homeViewModel.fetchWheatherData(userLocation)
        }
        .padding()
    }
}

#Preview {
    ContentView(cityName: "")
}
