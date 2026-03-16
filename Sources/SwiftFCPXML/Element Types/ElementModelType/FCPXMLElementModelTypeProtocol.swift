//
//  FCPXMLElementModelTypeProtocol.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2023 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation

public protocol FCPXMLElementModelTypeProtocol<ModelType> 
where Self: Equatable, Self: Hashable, Self: Sendable
{
    associatedtype ModelType: FCPXMLElement
    var supportedElementTypes: Set<FCPXML.ElementType> { get }
}

extension FCPXMLElementModelTypeProtocol {
    public var supportedElementTypes: Set<FCPXML.ElementType> {
        ModelType.supportedElementTypes
    }
}

#endif
