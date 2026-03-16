//
//  FCPXML AudioRoleSource.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2023 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftTimecodeCore
import SwiftExtensions

extension FCPXML {
    /// FCPXML 1.11 DTD:
    /// "An `audio-role-source` element adjusts playback settings for a single role-based audio
    /// component in a clip."
    public struct AudioRoleSource: FCPXMLElement, Equatable, Hashable {
        public let element: XMLElement
        
        public let elementType: ElementType = .audioRoleSource
        
        public static let supportedElementTypes: Set<ElementType> = [.audioRoleSource]
        
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

extension FCPXML.AudioRoleSource {
    public init(
        role: FCPXML.AudioRole,
        active: Bool = true
    ) {
        self.init()
        
        self.role = role
        self.active = active
    }
}

// MARK: - Structure

extension FCPXML.AudioRoleSource {
    public enum Attributes: String {
        /// Role the audio component is associated with.
        case role
        /// Active state of the audio role source.
        case active // default true
    }
    
    // can contain adjusts
    // can contain filters
}

// MARK: - Attributes

extension FCPXML.AudioRoleSource {
    /// Role the audio component is associated with.
    public var role: FCPXML.AudioRole {
        get { 
            element.fcpRole(as: FCPXML.AudioRole.self)
                ?? .defaultAudioRole
        }
        nonmutating set { element.fcpSet(role: newValue) }
    }
    
    /// Active state of the audio role source.
    public var active: Bool {
        get { element.fcpGetActive(default: true) }
        nonmutating set { element.fcpSet(active: newValue, default: true) }
    }
}

// MARK: - Children

extension FCPXML.AudioRoleSource {
    /// Get or set child elements.
    public var contents: LazyCompactMapSequence<[XMLNode], XMLElement> {
        get { element.childElements }
        nonmutating set {
            element.removeAllChildren()
            element.addChildren(newValue)
        }
    }
}

// MARK: - Typing

// AudioRoleSource
extension XMLElement {
    /// FCPXML: Returns the element wrapped in a ``FCPXML/AudioRoleSource`` model object.
    /// Call this on a `audio-role-source` element only.
    public var fcpAsAudioRoleSource: FCPXML.AudioRoleSource? {
        .init(element: self)
    }
}

// MARK: - Collection Methods

extension Sequence where Element == FCPXML.AudioRoleSource {
    /// Convert and wrap the audio role source as ``FCPXML/AnyRole``
    public func asAnyRoles() -> [FCPXML.AnyRole] {
        compactMap { $0.role }
            .compactMap { .audio($0) }
    }
}

#endif
