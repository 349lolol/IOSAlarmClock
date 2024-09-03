//
//  ContentView.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-08-02.
//

import SwiftUI

struct ContentView: View {
    @StateObject public var alarmManager = AlarmManager()
    @ObservedObject public var weatherData = WeatherData.shared
    @State public var storedText: String = ""
    @State public var selectedOption = 0
    @State public var showAlarmTriggeredView = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Resizable text field with auto-save
                ResizeableTextField(storedText: $storedText)

                // Dropdown menu for customizable options
                DropdownMenuView(selectedOption: $selectedOption, options: ["Morning Flower", "Over the Horizon", "Option 3", "Option 4"])

                // Alarm settings view with infinite scrolling UI
                AlarmSettingsView(alarmManager: alarmManager)

                // navigate to AlarmTriggered
                NavigationLink(
                    destination: AlarmTriggeredView(alarmTriggered: AlarmTriggered.shared),
                    isActive: $showAlarmTriggeredView
                ) {
                    EmptyView()
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Alarm Settings")
            .onAppear {
                startAlarmChecker()
                listenForAlarmTrigger()
            }
        }
    }

    func startAlarmChecker() {
        alarmManager.startAlarmChecker()
    }

    func listenForAlarmTrigger() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("AlarmTriggered"), object: nil, queue: .main) { _ in
            handleAlarmTrigger()
        }
    }

    func handleAlarmTrigger() {
        DispatchQueue.main.async {
            showAlarmTriggeredView = true

            // Play the selected alarm sound
            AlarmTriggered.shared.playAlarmSound(named: selectedOption == 0 ? "MorningFlower" : "OverTheHorizon")

            // Refresh weather data
            refreshWeatherData()
        }
    }

    // Function to refresh weather data asynchronously
    func refreshWeatherData() {
        Task {
            do {
                //https://open-meteo.com/en/docs#latitude=43.8711&longitude=-79.4373&hourly=&daily=weather_code,temperature_2m_max,temperature_2m_min,uv_index_max,precipitation_sum&timezone=America%2FNew_York&forecast_days=1
                try await weatherData.fetchWeatherData(latitude: 43, longitude: -79, timezone: "America/New_York")
            } catch {
                print("Failed to fetch weather data: \(error.localizedDescription)")
            }
        }
    }
}
