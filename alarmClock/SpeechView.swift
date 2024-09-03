import SwiftUI

struct SpeechView: View {
    @ObservedObject var speech = Speech.shared
    @ObservedObject var weatherData = WeatherData.shared
    @Environment(\.presentationMode) var presentationMode
    var storedText: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Reminders")
                .font(.largeTitle)
                .fontWeight(.bold)

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
        .navigationTitle("Speech")
        .onAppear {
            Task {
                let weatherDescription = "Here's the weather today: " + weatherData.generateWeatherDescription() + " Here are your notes for the day: " + storedText

                // Start speaking the weather description and notes
                Speech.shared.startSpeaking(text: weatherDescription)
            }
        }
    }
}
