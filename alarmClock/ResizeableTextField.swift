
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
                .foregroundColor(.blue) // Custom font color

            TextEditor(text: $userText)
                .font(.body) // Custom font
                .padding(10) // Add padding inside the text editor
                .background(Color(.white)) // Background color for the text editor
                .cornerRadius(12) // Rounded corners
                .overlay(
                    RoundedRectangle(cornerRadius: 12) // Border with rounded corners
                        .stroke(Color.blue, lineWidth: 2) // Custom border color and width
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
