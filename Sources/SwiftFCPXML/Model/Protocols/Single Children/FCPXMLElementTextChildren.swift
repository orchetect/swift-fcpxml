//
//  FCPXMLElementTextChildren.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2023 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftExtensions
import SwiftTimecodeCore

public protocol FCPXMLElementTextChildren: FCPXMLElement {
    /// Child `text` elements.
    var texts: LazyFCPXMLChildrenSequence<FCPXML.Text> { get nonmutating set }
}

extension FCPXMLElementTextChildren {
    public var texts: LazyFCPXMLChildrenSequence<FCPXML.Text> {
        get { element.fcpTexts }
        nonmutating set { element.fcpTexts = newValue }
    }
}

extension XMLElement {
    /// FCPXML: Returns child `text` elements.
    public var fcpTexts: LazyFCPXMLChildrenSequence<FCPXML.Text> {
        get { children(whereFCPElement: .text) }
        set { _updateChildElements(ofType: .text, with: newValue) }
    }
}

#endif
