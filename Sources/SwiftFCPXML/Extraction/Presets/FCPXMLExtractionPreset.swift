//
//  FCPXMLExtractionPreset.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2022 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation

/// Protocol describing an element extraction preset for FCPXML.
public protocol FCPXMLExtractionPreset<Result> where Self: Sendable {
    associatedtype Result
    
    func perform(
        on extractable: XMLElement,
        scope: FCPXML.ExtractionScope
    ) async -> Result
}

#endif
