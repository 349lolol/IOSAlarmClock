//
//  SpeechViewModel.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-09-03.
//

import Foundation
import AVFoundation

class SpeechViewModel: ObservableObject {
    private var speechSynthesizer = AVSpeechSynthesizer()

    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(utterance)
    }

    func stopSpeaking() {
        speechSynthesizer.stopSpeaking(at: .immediate)
    }
}
