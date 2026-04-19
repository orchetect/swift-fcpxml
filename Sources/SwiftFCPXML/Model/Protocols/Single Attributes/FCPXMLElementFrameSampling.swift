//
//  FCPXMLElementFrameSampling.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftTimecodeCore

public protocol FCPXMLElementFrameSampling: FCPXMLElement {
    /// Frame sampling. (Default: floor)
    var frameSampling: FCPXML.FrameSampling { get nonmutating set }
}

extension FCPXMLElementFrameSampling {
    private var _frameSamplingDefault: FCPXML.FrameSampling {
        .floor
    }

    public var frameSampling: FCPXML.FrameSampling {
        get {
            guard let value = element.stringValue(forAttributeNamed: "frameSampling")
            else { return _frameSamplingDefault }

            return FCPXML.FrameSampling(rawValue: value) ?? _frameSamplingDefault
        }
        nonmutating set {
            if newValue == _frameSamplingDefault {
                // can remove attribute if value is default
                element.removeAttribute(forName: "frameSampling")
            } else {
                element.addAttribute(withName: "frameSampling", value: newValue.rawValue)
            }
        }
    }
}

#endif
