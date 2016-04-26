import XCTest
@testable import Resource

class ResourceTests: XCTestCase {
    func testReality() {
        XCTAssert(2 + 2 == 4, "Something is severely wrong here.")
    }
}

extension ResourceTests {
    static var allTests: [(String, ResourceTests -> () throws -> Void)] {
        return [
           ("testReality", testReality),
        ]
    }
}
