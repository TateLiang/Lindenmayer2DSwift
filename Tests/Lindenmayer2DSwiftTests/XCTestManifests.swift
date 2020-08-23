import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Lindenmayer2DSwiftTests.allTests),
    ]
}
#endif
