
//
//  ResizeableTextField.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-08-10.
//


import SwiftUI
import Foundation
import OpenMeteoSdk


class WeatherData: ObservableObject {
    static let shared = WeatherData()

    @Published public var date: Date?
    @Published public var weatherCode: Float?
    @Published public var temperature2mMax: Float?
    @Published public var temperature2mMin: Float?
    @Published public var uvIndexMax: Float?
    @Published public var precipitationSum: Float?

    private init() { }

    func fetchWeatherData(latitude: Double, longitude: Double, timezone: String) async throws {
        let urlString = "https://open-meteo.com/en/docs#latitude=43.8711&longitude=-79.4373&hourly=&daily=weather_code,temperature_2m_max,temperature_2m_min,uv_index_max,precipitation_sum&timezone=America%2FNew_York&forecast_days=1&format=flatbuffers"
        


        //https://open-meteo.com/en/docs#latitude=43.8711&longitude=-79.4373&hourly=&daily=weather_code,temperature_2m_max,temperature_2m_min,uv_index_max,precipitation_sum&timezone=America%2FNew_York&forecast_days=1
        
        
//        guard let url = URL(string: urlString) else {
//            throw URLError(.badURL)
//        }
        let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=43.8711&longitude=-79.4373&daily=weather_code,temperature_2m_max,temperature_2m_min,uv_index_max,precipitation_sum&timezone=America%2FNew_York&forecast_days=1&format=flatbuffers")!
        let responses = try await WeatherApiResponse.fetch(url: url)
        
        //let responses = try await WeatherApiResponse.fetch(url: url)
        let response = responses[0]
        let utcOffsetSeconds = response.utcOffsetSeconds
        let daily = response.daily!

        let formattedDate = daily.getDateTime(offset: utcOffsetSeconds)[0]

        DispatchQueue.main.async {
            self.date = formattedDate
            self.weatherCode = daily.variables(at: 0)!.values[0]
            self.temperature2mMax = daily.variables(at: 1)!.values[0]
            self.temperature2mMin = daily.variables(at: 2)!.values[0]
            self.uvIndexMax = daily.variables(at: 3)!.values[0]
            self.precipitationSum = daily.variables(at: 4)!.values[0]
        }
    }
}
extension WeatherData {
    func generateWeatherDescription() -> String {
        var description = ""

        // Interpret the weather code
        if let weatherCode = weatherCode {
            switch weatherCode {
            case 0:
                description += "Clear sky."
            case 1, 2, 3:
                description += "Some clouds."
            case 45, 48:
                description += "Fog or depositing rime fog."
            case 51, 53, 55:
                description += "Drizzle with light to dense intensity."
            case 56, 57:
                description += "Freezing drizzle with light or dense intensity."
            case 61, 63, 65:
                description += "Rain with slight to heavy intensity."
            case 66, 67:
                description += "Freezing rain with light or heavy intensity."
            case 71, 73, 75:
                description += "Snowfall with slight to heavy intensity."
            case 77:
                description += "Snow grains."
            case 80, 81, 82:
                description += "Rain showers with slight to violent intensity."
            case 85, 86:
                description += "Snow showers with slight or heavy intensity."
            case 95:
                description += "Thunderstorm with slight or moderate intensity."
            case 96, 99:
                description += "Thunderstorm with slight or heavy hail."
            default:
                description += "Unknown weather conditions."
            }
        }

        // Add temperature information
        if let tempMax = temperature2mMax, let tempMin = temperature2mMin {
            description += " The temperature will range from \(Int(tempMin))°C to \(Int(tempMax))°C."
        }

        // Add UV index information
        if let uvIndex = uvIndexMax {
            description += " The maximum UV index will be \(Int(uvIndex))."
        }

        // Add precipitation information with qualitative description
        if let precipitation = precipitationSum {
            let precipitationDescription: String
            switch precipitation {
            case 0..<1:
                precipitationDescription = "No significant precipitation expected."
            case 1..<5:
                precipitationDescription = "Light precipitation expected."
            case 5..<10:
                precipitationDescription = "Moderate precipitation expected."
            case 10...:
                precipitationDescription = "Heavy precipitation expected."
            default:
                precipitationDescription = "Unknown precipitation conditions."
            }
            description += " \(precipitationDescription)"
        }

        return description
    }
}
