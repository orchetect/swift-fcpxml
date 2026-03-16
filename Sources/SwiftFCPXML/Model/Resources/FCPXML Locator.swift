//
//  FCPXML Locator.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2022 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation

extension FCPXML {
    /// Locator shared resource.
    ///
    /// > Final Cut Pro FCPXML 1.11 Reference:
    /// >
    /// > Describe a URL-based resource.
    /// >
    /// > Use the `locator` element to describe the location of data files associated with another
    /// > FCPXML element.
    /// >
    /// > See [`locator`](https://developer.apple.com/documentation/professional_video_applications/fcpxml_reference/locator).
    public struct Locator: FCPXMLElement {
        public let element: XMLElement
        
        public let elementType: ElementType = .locator
        
        public static let supportedElementTypes: Set<ElementType> = [.locator]
        
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

extension FCPXML.Locator {
    public init(
        id: String,
        url: URL? = nil
    ) {
        self.init()
        
        self.id = id
        self.url = url
    }
}

// MARK: - Structure

extension FCPXML.Locator {
    public enum Attributes: String {
        /// Required.
        /// Identifier.
        case id
        
        /// Required.
        /// Absolute URL or relative URL to library path.
        case url
    }
}

// MARK: - Attributes

extension FCPXML.Locator {
    /// Required.
    /// Identifier.
    public var id: String {
        get { element.fcpID ?? "" }
        nonmutating set { element.fcpID = newValue }
    }
    
    /// Required.
    /// Absolute URL or relative URL to library path.
    public var url: URL? {
        get { element.getURL(forAttribute: Attributes.url.rawValue) }
        nonmutating set { element.set(url: newValue, forAttribute: Attributes.url.rawValue) }
    }
}

// MARK: - Children

extension FCPXML.Locator: FCPXMLElementBookmarkChild { }

// MARK: - Typing

// Locator
extension XMLElement {
    /// FCPXML: Returns the element wrapped in a ``FCPXML/Locator`` model object.
    /// Call this on a `locator` element only.
    public var fcpAsLocator: FCPXML.Locator? {
        .init(element: self)
    }
}

#endif
