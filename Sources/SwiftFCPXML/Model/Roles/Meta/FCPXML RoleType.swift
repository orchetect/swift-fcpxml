//
//  FCPXML RoleType.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftTimecodeCore

extension FCPXML {
    /// Role type/classification.
    public enum RoleType: String, Equatable, Hashable, CaseIterable, Sendable {
        /// Audio role.
        case audio

        /// Video role.
        case video

        /// Closed caption role.
        case caption
    }
}

extension Set<FCPXML.RoleType> {
    public static let allCases: Self = Set(Element.allCases)
}

#endif
