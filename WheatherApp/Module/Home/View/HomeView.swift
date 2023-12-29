//
//  ContentView.swift
//  WheatherApp
//
//  Created by Amr Hassan on 28/12/2023.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: - Properties
    @StateObject private var homeViewModel = HomeViewModel()
    
    //MARK: - UI
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter Location", text: $homeViewModel.cityName)
                    Button {
                        homeViewModel.getWeatherForecast(for: homeViewModel.cityName)
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                    }
                }
                List(homeViewModel.forcastDays, id: \.forcastDay.date) { day in
                    VStack(alignment: .leading) {
                        Text(day.forcastDay.date)
                            .fontWeight(.bold)
                        HStack(alignment: .center) {
                            AsyncImage(url: day.whetherIconUrl, content: { image in
                                image.resizable()
                            }, placeholder: {
                                Image(systemName: "hourglass")
                            })
                            .frame(width: 50, height: 50)
                            VStack(alignment: .leading) {
                                Text(day.overView)
                                HStack {
                                    Text(day.high)
                                    Text(day.low)
                                }
                                Text(day.rain)
                                Text(day.humidity)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .onAppear() { homeViewModel.getWeatherForecast(for: homeViewModel.userLocation) }
            .padding(.horizontal)
            .navigationTitle("Wheather App")
            .alert(item: $homeViewModel.appError) { appAlert in
                Alert(title: Text("Error"),
                      message: Text("""
                                  \(appAlert.errorString)
                                  please try again
                                  """
                                   )
                )
            }
        }
    }
}

#Preview {
    HomeView()
}
