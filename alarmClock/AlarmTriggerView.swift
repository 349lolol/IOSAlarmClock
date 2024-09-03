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

    var body: some View {
        VStack(spacing: 20) {
            Text("Alarm Triggered!")
                .font(.largeTitle)
                .fontWeight(.bold)

            // Button to stop the alarm sound and go back to the first page
            Button(action: {
                alarmTriggered.stopAlarm()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Stop Alarm")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Alarm Triggered")
    }
}
