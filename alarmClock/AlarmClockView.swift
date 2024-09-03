//
//  AlarmClockView.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-08-03.
//

import SwiftUI
import UIKit

struct AlarmClockView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> AlarmClockViewController {
        return AlarmClockViewController()
    }

    func updateUIViewController(_ uiViewController: AlarmClockViewController, context: Context) {
    }
}
