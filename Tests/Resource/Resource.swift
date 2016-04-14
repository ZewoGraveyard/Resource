import XCTest
@testable import Resource

class Resource: XCTestCase {
	func testExample() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.
	}
}

#if os(Linux)
extension Resource: XCTestCaseProvider {
	var allTests : [(String, () throws -> Void)] {
		return [
			("testExample", testExample),
		]
	}
}
#endif
