//
//  FCPXMLElementModDate.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2023 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftTimecodeCore

public protocol FCPXMLElementOptionalModDate: FCPXMLElement {
    /// Modification date.
    var modDate: String? { get nonmutating set }
}

extension FCPXMLElementOptionalModDate {
    public var modDate: String? {
        get { element.stringValue(forAttributeNamed: "modDate") }
        nonmutating set { element.addAttribute(withName: "modDate", value: newValue) }
    }
}

#endif
