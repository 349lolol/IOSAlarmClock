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

                presentationMode.wrappedValue.dismiss()

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
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Daily Reminders")
                    .font(.custom("Roboto", size: 24))
                    .foregroundColor(.primary)
                    .bold()
            }
        }
        .frame(width: 330)
        .onAppear {
            Task {
                let narratorScript = "Here's the weather today: " + weatherData.generateWeatherDescription() + " Here are your notes for the day: " + storedText

                Speech.shared.startSpeaking(text: narratorScript)
            }
        }
    }
}
