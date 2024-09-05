//
//  AttributeProcessorTests.swift
//  MeasureSDKTests
//
//  Created by Adwin Ross on 04/09/24.
//

import XCTest
@testable import MeasureSDK

final class AttributeProcessorTests: XCTestCase {
    func testAppendsAttributes() {
        var attributes: [String: Any?] = [:]

        let attributeProcessor1 = MockAttributeProcessor { attributes in
            attributes["key1"] = "value1"
        }
        let attributeProcessor2 = MockAttributeProcessor { attributes in
            attributes["key2"] = "value2"
        }

        let processors: [AttributeProcessor] = [attributeProcessor1, attributeProcessor2]
        processors.forEach { $0.appendAttributes(&attributes) }

        XCTAssertTrue(attributes.keys.contains("key1"))
        XCTAssertEqual(attributes["key1"] as? String, "value1")
        XCTAssertTrue(attributes.keys.contains("key2"))
        XCTAssertEqual(attributes["key2"] as? String, "value2")
    }

    func testUpdatesValueIfTwoProcessorsSetSameKey() {
        var attributes: [String: Any?] = [:]

        let attributeProcessor1 = MockAttributeProcessor { attributes in
            attributes["key"] = "value1"
        }
        let attributeProcessor2 = MockAttributeProcessor { attributes in
            attributes["key"] = "value2"
        }

        let processors: [AttributeProcessor] = [attributeProcessor1, attributeProcessor2]
        processors.forEach { $0.appendAttributes(&attributes) }

        XCTAssertEqual(attributes["key"] as? String, "value2")
    }

    func testNoopWhenEmptyListOfProcessorsIsPassed() {
        var attributes: [String: Any?] = [:]

        let processors: [AttributeProcessor] = []
        processors.forEach { $0.appendAttributes(&attributes) }

        XCTAssertEqual(attributes.count, 0)
    }
}
