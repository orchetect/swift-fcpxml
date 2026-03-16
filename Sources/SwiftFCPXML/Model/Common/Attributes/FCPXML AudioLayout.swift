//
//  FCPXML AudioLayout.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2022 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation

extension FCPXML {
    /// `audioLayout` attribute value.
    public enum AudioLayout: String, Equatable, Hashable, CaseIterable, Sendable {
        case mono
        case stereo
        case surround
    }
}

extension FCPXML.AudioLayout: FCPXMLAttribute {
    public static let attributeName: String = "audioLayout"
}

#endif
