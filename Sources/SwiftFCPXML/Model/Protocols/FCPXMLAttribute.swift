//
//  FCPXMLAttribute.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftTimecodeCore

public protocol FCPXMLAttribute {
    /// The XML attribute name.
    static var attributeName: String { get }
}

#endif
