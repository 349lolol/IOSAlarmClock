
//
//  ResizeableTextField.swift
//  alarmClock
//
//  Created by Patrick Wei on 2024-08-10.
//
import SwiftUI

struct ResizeableTextField: View {
    @Binding var storedText: String
    @State private var userText: String

    init(storedText: Binding<String>) {
        self._storedText = storedText
        self._userText = State(initialValue: storedText.wrappedValue)
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter your notes:")
                .font(.headline)
                .foregroundColor(.blue)

            TextEditor(text: $userText)
                .font(.body)
                .padding(10)
                .background(Color(.white))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.blue, lineWidth: 2)
                )
                .frame(height: 150)
                .frame(width: 330)
                .padding(.horizontal)
                .onChange(of: userText) { newValue in
                    storedText = newValue
                }
        }
        .padding()
    }
}

#Preview {
    ResizeableTextField(storedText: .constant(""))
}
