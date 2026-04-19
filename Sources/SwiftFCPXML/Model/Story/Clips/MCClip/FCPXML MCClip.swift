//
//  FCPXML MCClip.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftExtensions
import SwiftTimecodeCore

extension FCPXML {
    /// References a multicam media.
    ///
    /// > Final Cut Pro FCPXML 1.11 Reference:
    /// >
    /// > Use an `mc-clip` element to describe a timeline sequence created from a multicam media. To
    /// > use multicam media as a clip, see [Using Multicam Media](
    /// > https://developer.apple.com/documentation/professional_video_applications/fcpxml_reference/story_elements/mc-clip
    /// > ). To specify the timing of the edit,
    /// > use the [Timing Attributes](
    /// > https://developer.apple.com/documentation/professional_video_applications/fcpxml_reference/story_elements/mc-clip
    /// > ).
    public struct MCClip: FCPXMLElement {
        public let element: XMLElement

        public let elementType: ElementType = .mcClip

        public static let supportedElementTypes: Set<ElementType> = [.mcClip]

        public init() {
            element = XMLElement(name: elementType.rawValue)
        }

        public init?(element: XMLElement) {
            self.element = element
            guard _isElementTypeSupported(element: element) else { return nil }
        }
    }
}

// MARK: - Parameterized init

extension FCPXML.MCClip {
    public init(
        ref: String,
        srcEnable: FCPXML.ClipSourceEnable = .all,
        // Audio Start/Duration
        audioStart: Fraction? = nil,
        audioDuration: Fraction? = nil,
        // Anchorable Attributes
        lane: Int? = nil,
        offset: Fraction? = nil,
        // Clip Attributes
        name: String? = nil,
        start: Fraction? = nil,
        duration: Fraction,
        enabled: Bool = true,
        // Mod Date
        modDate: String? = nil,
        // Note child
        note: String? = nil,
        // Metadata
        metadata: FCPXML.Metadata? = nil
    ) {
        self.init()

        self.ref = ref
        self.srcEnable = srcEnable

        // Audio Start/Duration
        self.audioStart = audioStart
        self.audioDuration = audioDuration

        // Anchorable Attributes
        self.lane = lane
        self.offset = offset

        // Clip Attributes
        self.name = name
        self.start = start
        self.duration = duration
        self.enabled = enabled

        // Mod Date
        self.modDate = modDate

        // Note child
        self.note = note

        // Metadata
        self.metadata = metadata
    }
}

// MARK: - Structure

extension FCPXML.MCClip {
    public enum Attributes: String {
        // Element-Specific Attributes
        case ref // required
        case srcEnable // (all, audio, video) default: all

        // Audio Start/Duration
        case audioStart
        case audioDuration

        // Anchorable Attributes
        case lane
        case offset

        // Clip Attributes
        case name
        case start
        case duration
        case enabled

        // Mod Date
        case modDate
    }

    // contains DTD mc-source*
    // contains DTD %timing-params
    // contains DTD %intrinsic-params-audio
    // can contain markers
    // can contain filter-audio
}

// MARK: - Attributes

extension FCPXML.MCClip {
    /// Resource ID. (Required)
    public var ref: String {
        get { element.fcpRef ?? "" }
        nonmutating set { element.fcpRef = newValue }
    }

    /// Sources to enable for audio and video. (Default: `.all`)
    public var srcEnable: FCPXML.ClipSourceEnable {
        get { element.fcpClipSourceEnable }
        nonmutating set { element.fcpClipSourceEnable = newValue }
    }
}

extension FCPXML.MCClip: FCPXMLElementClipAttributes { }

extension FCPXML.MCClip: FCPXMLElementAudioStartAndDuration { }

extension FCPXML.MCClip: FCPXMLElementOptionalModDate { }

// MARK: - Children

extension FCPXML.MCClip {
    /// Get or set child elements.
    public var contents: LazyCompactMapSequence<[XMLNode], XMLElement> {
        get { element.childElements }
        nonmutating set {
            element.removeAllChildren()
            element.addChildren(newValue)
        }
    }

    /// Returns child story elements.
    public var storyElements: LazyFilteredCompactMapSequence<[XMLNode], XMLElement> {
        element.fcpStoryElements
    }
}

extension FCPXML.MCClip: FCPXMLElementNoteChild { }

extension FCPXML.MCClip: FCPXMLElementMetadataChild { }

extension FCPXML.MCClip /* FCPXMLElementMCSourceChildren */ {
    /// Returns child `mc-source` elements.
    public var sources: LazyFCPXMLChildrenSequence<FCPXML.MulticamSource> {
        get { element.fcpMulticamSources }
        nonmutating set { element.fcpMulticamSources = newValue }
    }
}

extension FCPXML.MCClip: FCPXMLElementTimingParams { }

// MARK: - Meta Conformances

extension FCPXML.MCClip: FCPXMLElementMetaTimeline {
    public func asAnyTimeline() -> FCPXML.AnyTimeline {
        .mcClip(self)
    }
}

// MARK: - Properties

extension FCPXML.MCClip {
    /// Locates the `media` resource used by the `mc-clip`, and returns the `multicam` element from
    /// within it.
    public var multicamResource: FCPXML.Media.Multicam? {
        element.fcpResource()?.fcpAsMedia?.multicam
    }

    /// Returns audio and video `mc-angle` elements from the `media` resource's `multicam` element
    /// that correspond to the angles used by the `mc-clip`'s `mc-source` children.
    ///
    /// These angles may be different, or may be the same, depending on if separate audio and video
    /// sources were selected in the `mc-source` element(s).
    public var audioVideoMCAngles: (
        audioMCAngle: FCPXML.Media.Multicam.Angle?,
        videoMCAngle: FCPXML.Media.Multicam.Angle?
    ) {
        let (audio, video) = multicamResource?.audioVideoMCAngles(forMulticamSources: sources)
            ?? (nil, nil)

        return (audio, video)
    }
}

// MARK: - Typing

// MCClip
extension XMLElement {
    /// FCPXML: Returns the element wrapped in a ``FCPXML/MCClip`` model object.
    /// Call this on a `mc-clip` element only.
    public var fcpAsMCClip: FCPXML.MCClip? {
        .init(element: self)
    }
}

// MARK: - Supporting Types

extension FCPXML.MCClip {
    public enum AngleMask: Equatable, Hashable, CaseIterable, Sendable {
        case active
        case all
    }
}

#endif
