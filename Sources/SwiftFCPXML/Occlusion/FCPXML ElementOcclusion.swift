//
//  FCPXML ElementOcclusion.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2023 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation

extension FCPXML {
    public enum ElementOcclusion: Equatable, Hashable, CaseIterable, Sendable {
        /// The element is not occluded at all by its parent.
        case notOccluded
        
        /// The element is partially occluded by its parent.
        case partiallyOccluded
        
        /// The element is fully occluded by its parent.
        case fullyOccluded
    }
}

extension Set<FCPXML.ElementOcclusion> {
    public static let allCases: Self = Set(Element.allCases)
}

#endif
