
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
