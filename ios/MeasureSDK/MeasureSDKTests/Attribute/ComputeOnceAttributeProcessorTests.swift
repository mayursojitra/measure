//
//  ComputeOnceAttributeProcessorTests.swift
//  MeasureSDKTests
//
//  Created by Adwin Ross on 04/09/24.
//

import XCTest
@testable import MeasureSDK

class ComputeOnceAttributeProcessorTests: XCTestCase {
    func testComputeAttributesIsOnlyCalledOnceWhenAppendingAttributes() {
        class TestComputeOnceAttributeProcessor: BaseComputeOnceAttributeProcessor {
            var computeAttributesCalledCount = 0

            override func computeAttributes() -> [String: Any?] {
                computeAttributesCalledCount += 1
                return ["key": "value"]
            }
        }

        let processor = TestComputeOnceAttributeProcessor()
        var attributes: [String: Any?] = [:]

        processor.appendAttributes(&attributes)
        processor.appendAttributes(&attributes)
        processor.appendAttributes(&attributes)

        XCTAssertEqual(processor.computeAttributesCalledCount, 1)
    }
}
