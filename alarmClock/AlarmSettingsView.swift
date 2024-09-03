//
//  AlarmSettingsView.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-08-03.
//

import SwiftUI

struct AlarmSettingsView: View {
    @ObservedObject var alarmManager: AlarmManager

    var body: some View {
        VStack(spacing: 20) {
            Text("Set Alarm Time:")
                .font(.headline)

            HStack {
                InfinitePickerView(
                    data: Array(arrayLiteral: 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11).map { "\($0)" },
                    selectedIndex: $alarmManager.selectedHour
                )
                InfinitePickerView(
                    data: Array(0...59).map { String(format: "%02d", $0) },
                    selectedIndex: $alarmManager.selectedMinute
                )
                InfinitePickerView(
                    data: ["AM", "PM"],
                    selectedIndex: Binding(
                        get: { alarmManager.selectedAmPm == "AM" ? 0 : 1 },
                        set: { alarmManager.selectedAmPm = $0 == 0 ? "AM" : "PM" }
                    )
                )
            }
            .frame(height: 150)

            Button(action: {
                alarmManager.startAlarmChecker()
            }) {
                Text("Set Alarm for \(formattedTime())")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding ()
    }

    // Helper function to format the selected time
    private func formattedTime() -> String {
        let hour = alarmManager.selectedHour == 0 ? 12 : alarmManager.selectedHour
        let minute = String(format: "%02d", alarmManager.selectedMinute)
        let amPm = alarmManager.selectedAmPm
        return "\(hour):\(minute) \(amPm)"
    }
}

#Preview {
    AlarmSettingsView(alarmManager: AlarmManager())
}
