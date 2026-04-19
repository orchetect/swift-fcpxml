//
//  FCPXML TimecodeFormat.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftTimecodeCore

extension FCPXML {
    /// `tcFormat` attribute value.
    public enum TimecodeFormat: String, Equatable, Hashable, CaseIterable, Sendable {
        case dropFrame = "DF"
        case nonDropFrame = "NDF"
    }
}

extension FCPXML.TimecodeFormat: FCPXMLAttribute {
    public static let attributeName: String = "tcFormat"
}

extension FCPXML.TimecodeFormat {
    /// Returns `true` if format is drop-frame.
    public var isDrop: Bool {
        switch self {
        case .dropFrame: true
        case .nonDropFrame: false
        }
    }
}

#endif
