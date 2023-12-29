//
//  WheatherViewModel.swift
//  WheatherApp
//
//  Created by Amr Hassan on 29/12/2023.
//

import Foundation

struct WheatherViewModel {
    
    let forcastDay: Forecastday
    
    private static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    var overView: String {
        forcastDay.day.condition.text.capitalized
    }
    
    var high: String {
        return "H: \(Self.numberFormatter.string(for: forcastDay.day.maxtempC) ?? "0") °C"
    }
    
    var low: String {
        return "L: \(Self.numberFormatter.string(for: forcastDay.day.mintempC) ?? "0") °C"
    }
    
    var rain: String {
        return "💧 \(Self.numberFormatter.string(for: forcastDay.day.dailyChanceOfRain) ?? "0") %"
    }
    
    var humidity: String {
        return "Humidity: \(Self.numberFormatter.string(for: forcastDay.day.avghumidity) ?? "0") %"
    }
    
    var whetherIconUrl: URL {
        let urlString = "https:\(forcastDay.day.condition.icon)"
        return URL(string: urlString)!
    }
}
