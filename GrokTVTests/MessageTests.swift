import XCTest
@testable import GrokTV

class MessageTests: XCTestCase {
    func testMessageInit() {
        let message = Message(content: "Hello", isUser: true)
        XCTAssertEqual(message.content, "Hello")
        XCTAssertEqual(message.isUser, true)
    }
}
