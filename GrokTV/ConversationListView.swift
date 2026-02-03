import SwiftUI

struct ConversationListView: View {
    @Binding var selectedConversation: Conversation?
    @ObservedObject private var manager = ConversationManager.shared

    var body: some View {
        List(selection: $selectedConversation) {
            ForEach(manager.conversations) { convo in
                Text(convo.title)
                    .font(.title2)
                    .padding()
                    .focusable() // tvOS focus optimization
            }
            .onDelete { indexSet in
                manager.deleteConversations(at: indexSet)
            }
        }
        .listStyle(.plain)
        .background(Color.black)
    }
}
