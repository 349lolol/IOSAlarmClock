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
                        .font(.headline)
                        .foregroundColor(.primary)
                }
            }
        } label: {
            HStack {
                Text(options[selectedOption])
                    .font(.headline)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Image(systemName: "chevron.down")
                    .frame(alignment: .trailing)
                    .foregroundColor(.blue)
            }
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.blue.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(12) // Rounded corners
            .overlay(
                RoundedRectangle(cornerRadius: 12) // Border with rounded corners
                    .stroke(Color.blue, lineWidth: 2) // Custom border color and width
            )
        }
        .padding(.horizontal) // Match the horizontal padding of the ResizeableTextField
    }
}
