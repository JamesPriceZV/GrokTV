import Foundation
import Combine
import SwiftUI
class ConversationManager: ObservableObject {
    static let shared = ConversationManager()
    private let storageKey = "conversations"
    @Published var conversations: [Conversation] = []

    private init() {
        loadConversations()
    }

    func addConversation(_ convo: Conversation) {
        conversations.append(convo)
        saveConversations()
    }

    func addMessage(to convoId: UUID, message: Message) {
        if let index = conversations.firstIndex(where: { $0.id == convoId }) {
            conversations[index].messages.append(message)
            saveConversations()
        }
    }

    func deleteConversations(at offsets: IndexSet) {
        conversations.remove(atOffsets: offsets)
        saveConversations()
    }

    private func saveConversations() {
        if let data = try? JSONEncoder().encode(conversations) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    private func loadConversations() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let loaded = try? JSONDecoder().decode([Conversation].self, from: data) {
            conversations = loaded
        }
    }
}

