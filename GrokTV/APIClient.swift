class APIClient {
    static let shared = APIClient()
    private let baseURL = "https://api.x.ai/v1"
    private let apiKey: String? = UserDefaults.standard.string(forKey: "apiKey")

    private init() {}
    func sendChatMessage(messages: [Message]) async throws -> String {
        guard let apiKey = apiKey, !apiKey.isEmpty else {
            throw NSError(domain: "Missing API Key", code: 0)
        }

        let url = URL(string: "\(baseURL)/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "grok-4", // Use latest model
            "messages": messages.map { ["role": $0.isUser ? "user" : "assistant", "content": $0.content] },
            "stream": true // For real-time UX
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: request)
        // Parse streaming response (simplified; in production, handle chunks)
        if let responseString = String(data: data, encoding: .utf8) {
            return responseString // Extract content from JSON chunks
        }
        throw NSError(domain: "Invalid Response", code: 0)
    }

    func generateImage(prompt: String) async throws -> URL? {
        guard let apiKey = apiKey, !apiKey.isEmpty else {
            throw NSError(domain: "Missing API Key", code: 0)
        }

        let url = URL(string: "\(baseURL)/images/generations")! // Assuming endpoint from docs
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "grok-4", // Or specific image model
            "prompt": prompt,
            "size": "1024x1024"
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: request)
        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
           let images = json["data"] as? [[String: String]],
           let imageURLString = images.first?["url"],
           let imageURL = URL(string: imageURLString) {
            return imageURL
        }
        return nil
    }
}

