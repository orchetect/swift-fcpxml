//
//  FCPXMLElementTCStart.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftTimecodeCore

public protocol FCPXMLElementOptionalTCStart: FCPXMLElement {
    /// Local timeline origin time.
    var tcStart: Fraction? { get nonmutating set }
}

extension FCPXMLElementOptionalTCStart {
    public var tcStart: Fraction? {
        get { element.fcpTCStart }
        nonmutating set { element.fcpTCStart = newValue }
    }

    /// Returns the start time of the element as timecode.
    public func tcStartAsTimecode(
        frameRateSource: FCPXML.FrameRateSource = .localToElement
    ) -> Timecode? {
        element._fcpTCStartAsTimecode(
            frameRateSource: frameRateSource
        )
    }
}

// MARK: - XML Utils

extension XMLElement {
    func _fcpTCStartAsTimecode(
        frameRateSource: FCPXML.FrameRateSource = .localToElement
    ) -> Timecode? {
        guard let tcStart = fcpTCStart else { return nil }
        return try? _fcpTimecode(
            fromRational: tcStart,
            frameRateSource: frameRateSource
        )
    }
}

#endif
