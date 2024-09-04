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

                // Navigate to AlarmTriggeredView when alarm is triggered
                NavigationLink(
                    destination: AlarmTriggeredView(alarmTriggered: AlarmTriggered.shared, storedText: storedText),
                    isActive: $showAlarmTriggeredView
                ) {
                    EmptyView()
                }

                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Alarm Settings")
                        .font(.custom("Roboto", size: 24))
                        .foregroundColor(.primary)
                        .bold()
                }
            }
            .onAppear {
                startAlarmChecker()
                listenForAlarmTrigger()
                NotificationCenter.default.addObserver(forName: NSNotification.Name("ClearNavigationStack"), object: nil, queue: .main) { _ in
                    showAlarmTriggeredView = false
                }
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

            AlarmTriggered.shared.playAlarmSound(named: selectedOption == 0 ? "MorningFlower" : "OverTheHorizon")
            
            refreshWeatherData()
        }
    }

    func refreshWeatherData() {
        Task {
            do {
                try await weatherData.fetchWeatherData(latitude: 43.6532, longitude: -79.3832, timezone: "America/Toronto")
            } catch {
                print("Failed to fetch weather data: \(error.localizedDescription)")
            }
        }
    }
}
