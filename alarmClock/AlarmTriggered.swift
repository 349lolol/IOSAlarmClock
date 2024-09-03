//
//  AlarmTriggered.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-08-30.
//

import AVFoundation

class AlarmTriggered: ObservableObject {
    static let shared = AlarmTriggered()
    
    private var audioPlayer: AVAudioPlayer?

    private init() {}
    
    func playAlarmSound(named soundFileName: String) {
        if let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.numberOfLoops = -1 
                audioPlayer?.play()
            } catch {
                print("Failed to play sound: \(error.localizedDescription)")
            }
        }
    }

    func stopAlarm() {
        audioPlayer?.stop()
    }
}
