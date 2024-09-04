//
//  InfiniteUIPickerView.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-08-10.
//

import UIKit

class InfiniteUIPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    public var items: [String] = []
    public let maxElements = 10000
    public var rowHeight: CGFloat
    public var onValueChange: (() -> Void)? // Closure to notify value change

    init(items: [String], rowHeight: CGFloat = 44) {
        self.items = items
        self.rowHeight = rowHeight
        super.init(frame: .zero)
        self.delegate = self
        self.dataSource = self
        self.selectRow((maxElements / 2) - ((maxElements / 2) % items.count), inComponent: 0, animated: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxElements
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return rowHeight
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let actualRow = row % items.count
        return items[actualRow]
    }

    func getCurrentValue() -> String {
        let selectedRow = self.selectedRow(inComponent: 0)
        return items[selectedRow % items.count]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        onValueChange?()  // Notify parent view controller about the value change
    }
}
