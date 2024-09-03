
//
//  InfiniteViewPicker.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-08-10.
//

import SwiftUI

struct InfinitePickerView: View {
    let data: [String]
    @Binding var selectedIndex: Int

    let rowHeight: CGFloat

    init(data: [String], selectedIndex: Binding<Int>, rowHeight: CGFloat = 44) {
        self.data = data
        self._selectedIndex = selectedIndex
        self.rowHeight = rowHeight
    }

    var body: some View {
        Picker("", selection: $selectedIndex) {
            ForEach(0..<data.count, id: \.self) { index in
                Text(data[index])
                    .frame(height: rowHeight)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(height: rowHeight * 3)
    }
}

#Preview {
    InfinitePickerView(data: Array(1...12).map { "\($0)" }, selectedIndex: .constant(0))
}
