//
//  FCPXML AudioRole.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftExtensions

extension FCPXML {
    /// Audio role.
    /// Contains a main role name with an optional sub-role.
    ///
    /// > Note:
    /// >
    /// > Role names cannot include a dot (`.`) or a question mark (`?`).
    /// > This is enforced by Final Cut Pro because they are reserved characters for encoding the
    /// > string in FCPXML.
    /// > This is how Final Cut Pro separates role and sub-role.
    /// > Otherwise, any other Unicode character is valid, including accented characters and emojis.
    public struct AudioRole: Equatable, Hashable, Sendable {
        public let role: String
        public let subRole: String?

        public init(role: String, subRole: String? = nil) {
            self.role = role
            self.subRole = subRole
        }
    }
}

extension FCPXML.AudioRole: FCPXMLRole {
    public var roleType: FCPXML.RoleType {
        .audio
    }

    public func asAnyRole() -> FCPXML.AnyRole {
        .audio(self)
    }

    public func lowercased(derivedOnly: Bool) -> Self {
        let newRole: String = role.lowercased()
        let newSubRole: String? = if derivedOnly, !isSubRoleDerivedFromMainRole {
            subRole
        } else {
            subRole?.lowercased()
        }

        return Self(role: newRole, subRole: newSubRole)
    }

    public func titleCased(derivedOnly: Bool) -> Self {
        let newRole: String = role.titleCased(firstCharacterOfWordsOnly: false, preserveUppercaseWords: false)
        let newSubRole: String? = if derivedOnly, !isSubRoleDerivedFromMainRole {
            subRole
        } else {
            subRole?.titleCased(firstCharacterOfWordsOnly: false, preserveUppercaseWords: false)
        }

        return Self(role: newRole, subRole: newSubRole)
    }

    public func titleCasedDefaultRole(derivedOnly: Bool) -> Self {
        isMainRoleBuiltIn
            ? titleCased(derivedOnly: derivedOnly)
            : self
    }

    public var isMainRoleBuiltIn: Bool {
        let builtInMainRoles = [
            "dialogue",
            "Dialogue",
            "effects",
            "Effects",
            "music",
            "Music"
        ]

        return builtInMainRoles.contains(role)
    }

    public var isSubRoleDerivedFromMainRole: Bool {
        FCPXML._isSubRole(subRole, derivedFromMainRole: role)
    }
}

extension FCPXML.AudioRole: RawRepresentable {
    public var rawValue: String {
        var rawRole = role
        if let subRole {
            rawRole += "." + subRole
        }
        return rawRole
    }

    public init?(rawValue: String) {
        guard let parsed = try? FCPXML._parseRawStandardRole(rawValue: rawValue)
        else { return nil }

        role = parsed.role
        subRole = parsed.subRole
    }
}

extension FCPXML.AudioRole: CustomDebugStringConvertible {
    public var debugDescription: String {
        "audio(\(rawValue.quoted))"
    }
}

extension FCPXML.AudioRole: FCPXMLCollapsibleRole {
    public func collapsingSubRole() -> Self {
        let collapsedValues = FCPXML._collapseStandardSubRole(
            role: role,
            subRole: subRole
        )
        return Self(role: collapsedValues.role, subRole: collapsedValues.subRole)
    }
}

#endif
