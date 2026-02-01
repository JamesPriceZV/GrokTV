import Foundation

struct Message: Identifiable, Codable, Hashable {
    let id: UUID
    let content: String
    let isUser: Bool
    init(id: UUID = UUID(), content: String, isUser: Bool) {
        self.id = id
        self.content = content
        self.isUser = isUser
    }
}

