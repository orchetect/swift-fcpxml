//
//  FCPXML ElementModelType.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation

// MARK: - ElementModelType

extension FCPXML {
    public struct ElementModelType<ModelType: FCPXMLElement>: FCPXMLElementModelTypeProtocol {
        public var supportedElementTypes: Set<FCPXML.ElementType> {
            ModelType.supportedElementTypes
        }

        init() { }
    }
}

#endif
