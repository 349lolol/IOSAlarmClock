//
//  SpeechManager.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-09-03.
//

import AVFoundation

class Speech: ObservableObject {
    static let shared = Speech()

    private var speechSynthesizer: AVSpeechSynthesizer

    private init() {
        speechSynthesizer = AVSpeechSynthesizer()
    }

    func startSpeaking(text: String) {
        if speechSynthesizer.isSpeaking {
            stopSpeaking()
        }
        
        let speechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate

        speechSynthesizer.speak(speechUtterance)
    }

    func stopSpeaking() {
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
        }
        
        // Reinitialize the speech synthesizer to ensure it's ready for the next cycle
        speechSynthesizer = AVSpeechSynthesizer()
    }
}
