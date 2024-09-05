//
//  AttributeProcessor.swift
//  MeasureSDK
//
//  Created by Adwin Ross on 03/09/24.
//

import Foundation

/// An interface marking a class as an attribute processor. It is responsible for generating, caching and appending attributes to an event. 
/// All attribute processors run must be safe to run in a background thread.
protocol AttributeProcessor {
    func appendAttributes(_ attributes: inout [String: Any?])
}
