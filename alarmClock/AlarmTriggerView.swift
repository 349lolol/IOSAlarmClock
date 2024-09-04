//
//  AlarmTriggerView.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-08-30.
//


import SwiftUI

struct AlarmTriggeredView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var alarmTriggered: AlarmTriggered
    @State private var navigateToSpeechView = false
    var storedText: String

    var body: some View {
        VStack(spacing: 20) {

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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Alarm Triggered")
                        .font(.custom("Roboto", size: 24)) 
                        .foregroundColor(.primary)
                        .bold()
                }
            }
            .frame(width: 330)
        }
        .padding()
    }
}
