//
//  FCPXML RolesExtractionPreset.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftExtensions

extension FCPXML {
    /// FCPXML extraction preset that extracts roles within a specified scope.
    /// Results are sorted by type, then by name.
    public struct RolesExtractionPreset: FCPXMLExtractionPreset {
        public var roleTypes: Set<RoleType>

        public init(
            roleTypes: Set<RoleType>
        ) {
            self.roleTypes = roleTypes
        }

        public func perform(
            on extractable: XMLElement,
            scope: FCPXML.ExtractionScope
        ) async -> [FCPXML.AnyRole] {
            // early return in case no types are specified
            guard !roleTypes.isEmpty else { return [] }

            let extracted = await extractable.fcpExtract(scope: scope) { element in
                element
                    .value(forContext: .inheritedRoles)
                    .filter(roleTypes: roleTypes)
                    .map(\.wrapped)
            }

            let output = extracted
                .flatMap(\.self)
                .removingDuplicates()
                .sortedByRoleTypeThenByName()

            return output
        }
    }
}

extension FCPXMLExtractionPreset where Self == FCPXML.RolesExtractionPreset {
    /// FCPXML extraction preset that extracts roles within a specified scope.
    /// Results are sorted by type, then by name.
    public static func roles(
        roleTypes: Set<FCPXML.RoleType> = .allCases
    ) -> FCPXML.RolesExtractionPreset {
        FCPXML.RolesExtractionPreset(
            roleTypes: roleTypes
        )
    }
}

#endif
