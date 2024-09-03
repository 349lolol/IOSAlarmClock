//
//  alarmManager.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-08-03.
//

import Foundation
import Combine

class AlarmManager: ObservableObject {
    @Published var selectedHour: Int = 0 {
        didSet { updateAlarmTime() }
    }
    @Published var selectedMinute: Int = 0 {
        didSet { updateAlarmTime() }
    }
    @Published var selectedAmPm: String = "AM" {
        didSet { updateAlarmTime() }
    }

    @Published private(set) var alarmTime: Date?
    private var timer: AnyCancellable?
    private var alarmTriggered = false

    init() {
        startAlarmChecker()
        updateAlarmTime()
    }

    func isAlarmTime(_ currentTime: Date) -> Bool {
        guard let alarmTime = alarmTime else { return false }
        let calendar = Calendar.current

        let alarmComponents = calendar.dateComponents([.hour, .minute], from: alarmTime)
        let currentComponents = calendar.dateComponents([.hour, .minute], from: currentTime)

        return alarmComponents.hour == currentComponents.hour && alarmComponents.minute == currentComponents.minute
    }

    private func updateAlarmTime() {
        var components = DateComponents()
        components.hour = selectedAmPm == "AM" ? selectedHour % 12 : (selectedHour % 12) + 12
        components.minute = selectedMinute
        components.second = 0

        alarmTime = Calendar.current.date(from: components)
    }

    func startAlarmChecker() {
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.checkAlarm()
            }
    }

    private func checkAlarm() {
        let currentTime = Date()
        if isAlarmTime(currentTime) && !alarmTriggered {
            alarmTriggered = true
            triggerAlarm()
        } else if !isAlarmTime(currentTime) {
            alarmTriggered = false
        }
    }

    private func triggerAlarm() {
        // Post a notification that the alarm has been triggered
        NotificationCenter.default.post(name: NSNotification.Name("AlarmTriggered"), object: nil)
    }
}
