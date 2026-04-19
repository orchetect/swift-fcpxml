//
//  FCPXML Root Parsing.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftExtensions
import SwiftTimecodeCore

extension XMLElement {
    /// FCPXML: Returns the root-level `fcpxml` element.
    /// This may be called on any element within a FCPXML.
    public var fcpRoot: XMLElement? {
        rootDocument?
            .rootElement() // `fcpxml` element
    }
}

#endif
