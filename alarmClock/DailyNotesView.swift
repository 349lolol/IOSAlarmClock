//
//  DailyNotes.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-08-10.
//

import SwiftUI

struct DailyNotes: View {
    @Binding var storedText: String
    @State private var userText: String

    init(storedText: Binding<String>) {
        self._storedText = storedText
        self._userText = State(initialValue: storedText.wrappedValue)
    }

    var body: some View {
        VStack(spacing: 20) {

                    Text("Enter notes here")
                        .font(.custom("Roboto", size: 12))  // Use your custom font
                        .foregroundColor(.primary)
                        .bold()

                .font(.headline)

            TextEditor(text: $userText)
                .frame(height: 150)
                .border(Color.gray, width: 1)
                .padding()
                .onChange(of: userText) { newValue in
                    storedText = newValue
                }
        }
        .padding()
    }
}

#Preview {
    DailyNotes(storedText: .constant(""))
}
