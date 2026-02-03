import SwiftUI

struct SettingsView: View {
    @AppStorage("apiKey") private var apiKey: String = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Text("Enter xAI API Key")
                .font(.title)
            TextField("API Key", text: $apiKey)
                .textFieldStyle(.roundedBorder)
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
