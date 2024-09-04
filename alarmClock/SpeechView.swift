//
//  SpeechView.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-09-03.
//

import SwiftUI

struct SpeechView: View {
    @ObservedObject var speech = Speech.shared
    @ObservedObject var weatherData = WeatherData.shared
    @Environment(\.presentationMode) var presentationMode
    var storedText: String

    var body: some View {
        VStack(spacing: 20) {

            Button(action: {
                Speech.shared.stopSpeaking()

                // Dismiss the current view
                presentationMode.wrappedValue.dismiss()

                // Send a notification to clear the navigation stack
                NotificationCenter.default.post(name: NSNotification.Name("ClearNavigationStack"), object: nil)
            }) {
                Text("Stop Speaking")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)  // Centers the title
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Daily Reminders")
                    .font(.custom("Roboto", size: 24))  // Use your custom font
                    .foregroundColor(.primary)
                    .bold()
            }
        }
        .frame(width: 330)
        .onAppear {
            Task {
                let weatherDescription = "Here's the weather today: " + weatherData.generateWeatherDescription() + " Here are your notes for the day: " + storedText

                // Start speaking the weather description and notes
                Speech.shared.startSpeaking(text: weatherDescription)
            }
        }
    }
}
