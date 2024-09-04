//
//  AlarmClockViewController.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-08-03.
//

import UIKit

class AlarmClockViewController: UIViewController {

    public let hourPicker = InfiniteUIPickerView(items: Array(1...12).map { String($0) }, rowHeight: 30)
    public let minutePicker = InfiniteUIPickerView(items: Array(0...59).map { String(format: "%02d", $0) }, rowHeight: 30)
    public let amPmPicker = InfiniteUIPickerView(items: ["AM", "PM"], rowHeight: 90)

    // Define the file path for storing picker values
    private var filePath: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("pickerValues.txt")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerViews()
        loadPickerValues()
        setupPickerValueChangeHandlers()
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

    private func setupPickerValueChangeHandlers() {
        hourPicker.onValueChange = { [weak self] in
            self?.savePickerValues()
        }
        minutePicker.onValueChange = { [weak self] in
            self?.savePickerValues()
        }
        amPmPicker.onValueChange = { [weak self] in
            self?.savePickerValues()
        }
    }

    func loadPickerValues() {
        var savedHour = "4"
        var savedMinute = "00"
        var savedAmPm = "AM"
        
        if FileManager.default.fileExists(atPath: filePath.path) {
            do {
                let savedData = try String(contentsOf: filePath, encoding: .utf8)
                let components = savedData.split(separator: " ")
                if components.count == 2 {
                    let timeComponents = components[0].split(separator: ":")
                    if timeComponents.count == 2 {
                        savedHour = String(timeComponents[0])
                        savedMinute = String(timeComponents[1])
                    }
                    savedAmPm = String(components[1])
                }
                print("Values loaded from file: \(savedHour):\(savedMinute) \(savedAmPm)")
            } catch {
                print("Failed to load values from file: \(error)")
            }
        }

        if let hourIndex = hourPicker.items.firstIndex(of: savedHour) {
            hourPicker.selectRow((hourIndex + hourPicker.maxElements / 2) % hourPicker.maxElements, inComponent: 0, animated: false)
        }

        if let minuteIndex = minutePicker.items.firstIndex(of: savedMinute) {
            minutePicker.selectRow((minuteIndex + minutePicker.maxElements / 2) % minutePicker.maxElements, inComponent: 0, animated: false)
        }

        if let amPmIndex = amPmPicker.items.firstIndex(of: savedAmPm) {
            amPmPicker.selectRow((amPmIndex + amPmPicker.maxElements / 2) % amPmPicker.maxElements, inComponent: 0, animated: false)
        }
    }

    func savePickerValues() {
        let hour = hourPicker.getCurrentValue()
        let minute = minutePicker.getCurrentValue()
        let amPm = amPmPicker.getCurrentValue()
        
        let dataToSave = "\(hour):\(minute) \(amPm)"
        
        do {
            try dataToSave.write(to: filePath, atomically: true, encoding: .utf8)
            print("Values saved to file: \(dataToSave)")
        } catch {
            print("Failed to save values to file: \(error)")
        }
    }

    func getSelectedTime() -> String {
        var savedHour = "4"
        var savedMinute = "00"
        var savedAmPm = "AM"
        
        if FileManager.default.fileExists(atPath: filePath.path) {
            do {
                let savedData = try String(contentsOf: filePath, encoding: .utf8)
                let components = savedData.split(separator: " ")
                if components.count == 2 {
                    let timeComponents = components[0].split(separator: ":")
                    if timeComponents.count == 2 {
                        savedHour = String(timeComponents[0])
                        savedMinute = String(timeComponents[1])
                    }
                    savedAmPm = String(components[1])
                }
            } catch {
                print("Failed to load values from file: \(error)")
            }
        }
        
        return "\(savedHour):\(savedMinute) \(savedAmPm)"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        savePickerValues()
    }
}
