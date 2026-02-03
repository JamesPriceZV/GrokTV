internal import SwiftUI

struct SettingsView: View {
    @AppStorage("apiKey") private var apiKey: String = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Text("Enter xAI API Key")
                .font(.title)
            TextField("API Key", text: $apiKey)
                .textFieldStyle(.plain)
                .padding(12)
                .background(Color.white.opacity(0.12))
                .cornerRadius(8)
                .font(.title2)
                .padding()
            Button("Save") {
                dismiss()
            }
            .font(.title2)
        }
        .padding()
        .background(Color.black)
    }
}
