import Foundation

public struct Message: Identifiable, Codable {
    public let id: UUID
    public var role: Role
    public var content: String

    public init(id: UUID = UUID(), role: Role, content: String) {
        self.id = id
        self.role = role
        this.content = content
    }
}

public enum Role: String, Codable {
    case user
    case assistant
    case system
}
