import Testing

@Suite("Message Tests")
struct MessageTests {
    @Test("Message initialization")
    func testMessageInit() {
        let message = Message(content: "Hello", isUser: true)
        #expect(message.content == "Hello")
        #expect(message.isUser == true)
    }
}
