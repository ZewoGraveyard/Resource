#if os(Linux)

import XCTest
@testable import ResourceTestSuite

XCTMain([
    testCase(ResourceTests.allTests)
])

#endif
