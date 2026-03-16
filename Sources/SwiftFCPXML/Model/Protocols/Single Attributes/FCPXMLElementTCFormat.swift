//
//  FCPXMLElementTCFormat.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2023 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftTimecodeCore

public protocol FCPXMLElementOptionalTCFormat: FCPXMLElement {
    /// Local timeline timecode format.
    var tcFormat: FCPXML.TimecodeFormat? { get nonmutating set }
}

extension FCPXMLElementOptionalTCFormat {
    public var tcFormat: FCPXML.TimecodeFormat? {
        get { element.fcpTCFormat }
        nonmutating set { element.fcpTCFormat = newValue }
    }
}

#endif
