//
//  MockAttributeProcessor.swift
//  MeasureSDKTests
//
//  Created by Adwin Ross on 04/09/24.
//

import Foundation
@testable import MeasureSDK

typealias AttributeAppendBlock = (inout [String: Any?]) -> Void

final class MockAttributeProcessor: AttributeProcessor {
    private let appendBlock: AttributeAppendBlock

    init(appendBlock: @escaping AttributeAppendBlock) {
        self.appendBlock = appendBlock
    }

    func appendAttributes(_ attributes: inout [String: Any?]) {
        appendBlock(&attributes)
    }
}
