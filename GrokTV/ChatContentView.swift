import SwiftUI

struct ChatContentView: View {
    @State private var selectedConversation: Conversation? = nil
    @State private var showSettings = false
    @AppStorage("apiKey") private var apiKey: String = ""
    var body: some View {
        NavigationSplitView {
            // Sidebar: Conversation list
            ConversationListView(selectedConversation: $selectedConversation)
                .navigationTitle("Conversations")
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button("New Chat") {
                            let newConvo = Conversation(id: UUID(), title: "New Conversation", messages: [])
                            ConversationManager.shared.addConversation(newConvo)
                            selectedConversation = newConvo
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button("Settings") {
                            showSettings = true
                        }
                    }
                }
        } detail: {
            // Main chat view
            if let convo = selectedConversation {
                ChatView(conversation: $selectedConversation)
            } else {
                Text("Select a conversation")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .onAppear {
            if apiKey.isEmpty {
                showSettings = true
            }
        }
        .background(Color.black) // Dark background for performance and UX
        .accentColor(.blue) // Blue accents mimicking Grok
    }
}
