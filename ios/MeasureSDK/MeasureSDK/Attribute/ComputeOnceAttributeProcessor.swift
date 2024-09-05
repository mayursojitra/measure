//
//  ComputeOnceAttributeProcessor.swift
//  MeasureSDK
//
//  Created by Adwin Ross on 03/09/24.
//

import Foundation

protocol ComputeOnceAttributeProcessor {
    func computeAttributes() -> [String: Any?]
}

/// Generates the attributes once and then caches them. Subsequent calls to [appendAttributes] will return the cached attributes. 
/// This is useful for attributes that are expensive to compute and are not expected to change.
///
/// Implementations should override [computeAttributes] to compute the attributes and do not need to override [appendAttributes].
///
class BaseComputeOnceAttributeProcessor: AttributeProcessor, ComputeOnceAttributeProcessor {
    private var isComputed = false
    private var cachedAttributes: [String: Any?]?

    func appendAttributes(_ attributes: inout [String: Any?]) {
        if !isComputed {
            cachedAttributes = computeAttributes()
            if let cachedAttrs = cachedAttributes {
                attributes.merge(cachedAttrs) { _, new in new }
            }
            isComputed = true
        } else if let cachedAttrs = cachedAttributes {
            attributes.merge(cachedAttrs) { _, new in new }
        }
    }

    func computeAttributes() -> [String: Any?] {
        fatalError("Subclasses must override computeAttributes()")
    }
}
