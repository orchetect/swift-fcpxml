//
//  FCPXML AudioRate.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation

extension FCPXML {
    /// `audioRate` attribute value.
    /// These are all of the rates that are selectable within Final Cut Pro 10.6.10.
    public enum AudioRate: Equatable, Hashable, CaseIterable, Sendable {
        case rate32kHz
        case rate44_1kHz
        case rate48kHz
        case rate88_2kHz
        case rate96kHz
        case rate176_4kHz
        case rate192kHz
    }
}

extension FCPXML.AudioRate: FCPXMLAttribute {
    public static let attributeName: String = "audioRate"
}

// `audioRate` attribute is used by two FCPXML elements: `asset` and `sequence`.
// The two encode it differently however.
// - `asset` encodes the value as "48000"
// - `sequence` encodes the value as "48k"

extension FCPXML.AudioRate {
    /// Attribute raw value for use in a `sequence` element.
    public var rawValueForSequence: String {
        switch self {
        case .rate32kHz: "32k"
        case .rate44_1kHz: "44.1k"
        case .rate48kHz: "48k"
        case .rate88_2kHz: "88.2k"
        case .rate96kHz: "96k"
        case .rate176_4kHz: "176.4k"
        case .rate192kHz: "192k"
        }
    }

    /// Initialize using attribute's raw value from a `sequence` element.
    public init?(rawValueForSequence rawValue: String) {
        guard let match = Self.allCases
            .first(where: { $0.rawValueForSequence == rawValue })
        else { return nil }
        self = match
    }
}

extension FCPXML.AudioRate {
    /// Attribute raw value for use in an `asset` element.
    public var rawValueForAsset: String {
        switch self {
        case .rate32kHz: "32000"
        case .rate44_1kHz: "44100"
        case .rate48kHz: "48000"
        case .rate88_2kHz: "88200"
        case .rate96kHz: "96000"
        case .rate176_4kHz: "176400"
        case .rate192kHz: "192000"
        }
    }

    /// Initialize using attribute's raw value from an `asset` element.
    public init?(rawValueForAsset rawValue: String) {
        guard let match = Self.allCases
            .first(where: { $0.rawValueForAsset == rawValue })
        else { return nil }

        self = match
    }
}

#endif
