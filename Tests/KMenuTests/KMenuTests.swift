import XCTest
@testable import KMenu

final class KMenuTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(KMenu().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
