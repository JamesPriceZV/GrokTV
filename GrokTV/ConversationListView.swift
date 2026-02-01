import SwiftUI

struct ConversationListView: View {
    @Binding var selectedConversation: Conversation?
    @State private var conversations = ConversationManager.shared.conversations
    var body: some View {
        List(selection: $selectedConversation) {
            ForEach(conversations) { convo in
                Text(convo.title)
                    .font(.title2)
                    .padding()
                    .focusable() // tvOS focus optimization
            }
            .onDelete { indexSet in
                ConversationManager.shared.deleteConversations(at: indexSet)
                conversations = ConversationManager.shared.conversations
            }
        }
        .listStyle(.plain)
        .background(Color.black)
        .onAppear {
            conversations = ConversationManager.shared.conversations
        }
        .onChange(of: ConversationManager.shared.conversations) { newValue in
            conversations = newValue
        }
    }
}

