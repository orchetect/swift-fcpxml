//
//  FCPXML Caption.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2022 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftTimecodeCore
import SwiftExtensions

extension FCPXML {
    /// Represents a closed caption.
    public struct Caption: FCPXMLElement { 
        public let element: XMLElement
        
        public let elementType: ElementType = .caption
        
        public static let supportedElementTypes: Set<ElementType> = [.caption]
        
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

extension FCPXML.Caption {
    public init(
        role: FCPXML.CaptionRole? = nil,
        note: String? = nil,
        // Anchorable Attributes
        lane: Int? = nil,
        offset: Fraction? = nil,
        // Clip Attributes
        name: String? = nil,
        start: Fraction? = nil,
        duration: Fraction,
        enabled: Bool = true
    ) {
        self.init()
        
        self.role = role
        self.note = note
        
        // Anchorable Attributes
        self.lane = lane
        self.offset = offset
        
        // Clip Attributes
        self.name = name
        self.start = start
        self.duration = duration
        self.enabled = enabled
    }
}

// MARK: - Structure

extension FCPXML.Caption {
    public enum Attributes: String {
        /// Role.
        ///
        /// The format is `role-name?captionFormat=captionFormat.subrole`.
        /// ie: `iTT?captionFormat=ITT.en`.
        case role
        case note
        
        // Anchorable Attributes
        case lane
        case offset
        
        // Clip Attributes
        case name
        case start
        case duration
        case enabled // default true
    }
    
    // contains `text` elements
    // contains `text-style-def` elements
}

// MARK: - Attributes

extension FCPXML.Caption {
    /// Role.
    ///
    /// The format is `role-name?captionFormat=captionFormat.subrole`.
    /// ie: `iTT?captionFormat=ITT.en`.
    public var role: FCPXML.CaptionRole? {
        get { element.fcpRole(as: FCPXML.CaptionRole.self) }
        nonmutating set { element.fcpSet(role: newValue) }
    }
}

extension FCPXML.Caption: FCPXMLElementClipAttributes { }

// MARK: - Children

extension FCPXML.Caption: FCPXMLElementNoteChild { }

extension FCPXML.Caption: FCPXMLElementTextChildren { }

extension FCPXML.Caption: FCPXMLElementTextStyleDefinitionChildren { }

// MARK: - Typing

// Caption
extension XMLElement {
    /// FCPXML: Returns the element wrapped in a ``FinalCutPro/FCPXML/Caption`` model object.
    /// Call this on a `caption` element only.
    public var fcpAsCaption: FCPXML.Caption? {
        .init(element: self)
    }
}

#endif
