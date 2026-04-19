//
//  FCPXML Title.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftExtensions
import SwiftTimecodeCore

extension FCPXML {
    /// Title clip.
    ///
    /// This is a FCP meta type and video is generated.
    /// Its frame rate is inferred from the sequence.
    /// Therefore, "tcFormat" (NDF/DF) attribute is not stored in `title` XML itself.
    public struct Title: FCPXMLElement {
        public let element: XMLElement

        public let elementType: ElementType = .title

        public static let supportedElementTypes: Set<ElementType> = [.title]

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

extension FCPXML.Title {
    public init(
        ref: String,
        role: FCPXML.VideoRole? = nil,
        // Anchorable Attributes
        lane: Int? = nil,
        offset: Fraction? = nil,
        // Clip Attributes
        name: String? = nil,
        start: Fraction? = nil,
        duration: Fraction,
        enabled: Bool = true,
        // Note child
        note: String? = nil,
        // Metadata
        metadata: FCPXML.Metadata? = nil
    ) {
        self.init()

        self.ref = ref
        self.role = role

        // Anchorable Attributes
        self.lane = lane
        self.offset = offset

        // Clip Attributes
        self.name = name
        self.start = start
        self.duration = duration
        self.enabled = enabled

        // Note child
        self.note = note

        // Metadata
        self.metadata = metadata
    }
}

// MARK: - Structure

extension FCPXML.Title {
    public enum Attributes: String {
        case ref // effect ID for a Motion template
        case role

        // Anchorable Attributes
        case lane
        case offset

        // Clip Attributes
        case name
        case start
        case duration
        case enabled
    }

    // can contain DTD param*
    // contains DTD %intrinsic-params-video
    // can contain DTD %anchor_item*
    // can contain markers
    // can contain DTD %video_filter_item*
}

// MARK: - Attributes

extension FCPXML.Title {
    /// Effect ID (resource ID) for a Motion template. (Required)
    public var ref: String {
        get { element.fcpRef ?? "" }
        nonmutating set { element.fcpRef = newValue }
    }

    public var role: FCPXML.VideoRole? {
        get { element.fcpRole(as: FCPXML.VideoRole.self) }
        nonmutating set { element.fcpSet(role: newValue) }
    }
}

extension FCPXML.Title: FCPXMLElementClipAttributes { }

// MARK: - Children

extension FCPXML.Title {
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

extension FCPXML.Title: FCPXMLElementNoteChild { }

extension FCPXML.Title: FCPXMLElementMetadataChild { }

extension FCPXML.Title: FCPXMLElementTextChildren { }

extension FCPXML.Title: FCPXMLElementTextStyleDefinitionChildren { }

// MARK: - Meta Conformances

extension FCPXML.Title: FCPXMLElementMetaTimeline {
    public func asAnyTimeline() -> FCPXML.AnyTimeline {
        .title(self)
    }
}

// MARK: - Typing

// Title
extension XMLElement {
    /// FCPXML: Returns the element wrapped in a ``FCPXML/Title`` model object.
    /// Call this on a `title` element only.
    public var fcpAsTitle: FCPXML.Title? {
        .init(element: self)
    }
}

#endif
