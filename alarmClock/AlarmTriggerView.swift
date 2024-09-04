import SwiftUI

struct AlarmTriggeredView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var alarmTriggered: AlarmTriggered
    @State private var navigateToSpeechView = false
    var storedText: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Alarm Triggered!")
                .font(.largeTitle)
                .fontWeight(.bold)

            Button(action: {
                alarmTriggered.stopAlarm()
                navigateToSpeechView = true
            }) {
                Text("Stop Alarm")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .background(
                NavigationLink(
                    destination: SpeechView(storedText: storedText),
                    isActive: $navigateToSpeechView
                ) {
                    EmptyView()
                }
                .hidden()
            )
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)  // Centers the title
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Alarm going off")
                    .font(.custom("Roboto", size: 24))  // Use your custom font
                    .foregroundColor(.primary)
                    .bold()
            }
        }
    }
}
