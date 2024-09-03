//
//  DropdownMenuView.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-08-10.
//

import SwiftUI

struct DropdownMenuView: View {
    @Binding var selectedOption: Int
    let options: [String]

    var body: some View {
        Menu {
            ForEach(0..<options.count) { index in
                Button(action: {
                    selectedOption = index
                }) {
                    Text(options[index])
                }
            }
        } label: {
            HStack {
                Text(options[selectedOption])
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Image(systemName: "chevron.down")
                    .frame(alignment: .trailing)
            }
            .padding()
            .frame(width: 200)
            .background(Color(.systemGray5))
            .cornerRadius(8)
        }
    }
}
