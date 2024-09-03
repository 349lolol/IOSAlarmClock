//
//  AlarmClockViewController.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-08-03.
//

import UIKit

class AlarmClockViewController: UIViewController {

    private let hourPicker = InfiniteUIPickerView(items: Array(1...12).map { String($0) }, rowHeight: 30)
    private let minutePicker = InfiniteUIPickerView(items: Array(0...59).map { String(format: "%02d", $0) }, rowHeight: 30)
    private let amPmPicker = InfiniteUIPickerView(items: ["AM", "PM"], rowHeight: 90)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerViews()
    }

    private func setupPickerViews() {
        let stackView = UIStackView(arrangedSubviews: [hourPicker, minutePicker, amPmPicker])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            stackView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    func getSelectedTime() -> String {
        let hour = hourPicker.getCurrentValue()
        let minute = minutePicker.getCurrentValue()
        let amPm = amPmPicker.getCurrentValue()
        return "\(hour):\(minute) \(amPm)"
    }
}
