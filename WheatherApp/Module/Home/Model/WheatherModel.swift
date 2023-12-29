//
//  WheatherModel.swift
//  WheatherApp
//
//  Created by Amr Hassan on 28/12/2023.
//

import Foundation

// MARK: - WheatherModel
struct WheatherModel: Codable {
    let location: Location?
    let current: Current?
    let forecast: Forecast?
}

// MARK: - Current
struct Current: Codable {
    let lastUpdated: String?
    let tempC: Int?
    let condition: Condition?
    let windDir: String?
    
    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case condition
        case windDir = "wind_dir"    }
}

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String?
    let code: Int?
}

enum WheatherIcon: String, Codable {
    case cdnWeatherapiCOMWeather64X64Day113PNG = "//cdn.weatherapi.com/weather/64x64/day/113.png"
    case cdnWeatherapiCOMWeather64X64Day116PNG = "//cdn.weatherapi.com/weather/64x64/day/116.png"
    case cdnWeatherapiCOMWeather64X64Day176PNG = "//cdn.weatherapi.com/weather/64x64/day/176.png"
    case cdnWeatherapiCOMWeather64X64Night113PNG = "//cdn.weatherapi.com/weather/64x64/night/113.png"
    case cdnWeatherapiCOMWeather64X64Night116PNG = "//cdn.weatherapi.com/weather/64x64/night/116.png"
    case cdnWeatherapiCOMWeather64X64Night119PNG = "//cdn.weatherapi.com/weather/64x64/night/119.png"
    case cdnWeatherapiCOMWeather64X64Night176PNG = "//cdn.weatherapi.com/weather/64x64/night/176.png"
}

enum WheatherText: String, Codable {
    case clear = "Clear"
    case cloudy = "Cloudy"
    case partlyCloudy = "Partly cloudy"
    case patchyRainPossible = "Patchy rain possible"
    case sunny = "Sunny"
}

// MARK: - Location
struct Location: Codable {
    let name, region, country: String?
    let lat, lon: Double?
    let localtime: String?
    
    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case localtime
    }
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]?
}

// MARK: - Forecastday
struct Forecastday: Codable {
    let date: String?
    let day: Day?
    let astro: Astro?
    let hour: [Hour]?
    
    enum CodingKeys: String, CodingKey {
        case date
        case day, astro, hour
    }
}

// MARK: - Astro
struct Astro: Codable {
    let sunrise, sunset, moonrise, moonset: String?
    let moonPhase: String?
    let moonIllumination, isMoonUp, isSunUp: Int?
    
    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
        case isMoonUp = "is_moon_up"
        case isSunUp = "is_sun_up"
    }
}

// MARK: - Day
struct Day: Codable {
    let maxtempC, mintempC: Double?
    let avgtempC: Double?
    let condition: Condition?
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case avgtempC = "avgtemp_c"
        case condition
    }
}

// MARK: - Hour
struct Hour: Codable {
    let time: String?
    let tempC: Double?
    let condition: Condition?
    
    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
    }
}
