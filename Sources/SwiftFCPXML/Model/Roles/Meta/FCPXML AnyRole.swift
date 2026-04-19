//
//  FCPXML AnyRole.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation

extension FCPXML {
    /// Type-erased box containing a specialized role instance.
    public enum AnyRole: Equatable, Hashable, Sendable {
        /// An audio role.
        case audio(_ role: AudioRole)

        /// A video role.
        case video(_ role: VideoRole)

        /// A closed caption role.
        case caption(_ role: CaptionRole)
    }
}

// MARK: - Static Constructors

extension FCPXML.AnyRole {
    /// An audio role.
    public static func audio(raw: String) -> Self? {
        guard let role = FCPXML.AudioRole(rawValue: raw) else { return nil }
        return .audio(role)
    }

    /// A video role.
    public static func video(raw: String) -> Self? {
        guard let role = FCPXML.VideoRole(rawValue: raw) else { return nil }
        return .video(role)
    }

    /// A closed caption role.
    public static func caption(raw: String) -> Self? {
        guard let role = FCPXML.CaptionRole(rawValue: raw) else { return nil }
        return .caption(role)
    }
}

extension FCPXML.AnyRole: FCPXMLRole {
    public var roleType: FCPXML.RoleType {
        wrapped.roleType
    }

    /// Redundant, but required to fulfill `FCPXMLRole` protocol requirements.
    public func asAnyRole() -> FCPXML.AnyRole {
        self
    }

    public func lowercased(derivedOnly: Bool) -> Self {
        wrapped
            .lowercased(derivedOnly: derivedOnly)
            .asAnyRole()
    }

    public func titleCased(derivedOnly: Bool) -> Self {
        wrapped
            .titleCased(derivedOnly: derivedOnly)
            .asAnyRole()
    }

    public func titleCasedDefaultRole(derivedOnly: Bool) -> Self {
        wrapped
            .titleCasedDefaultRole(derivedOnly: derivedOnly)
            .asAnyRole()
    }

    public var isMainRoleBuiltIn: Bool {
        wrapped.isMainRoleBuiltIn
    }
}

extension FCPXML.AnyRole {
    public func collapsingSubRole() -> Self {
        switch self {
        case let .audio(role): role.collapsingSubRole().asAnyRole()
        case let .video(role): role.collapsingSubRole().asAnyRole()
        case let .caption(role): role.collapsingSubRole().asAnyRole()
        }
    }
}

extension FCPXML.AnyRole: RawRepresentable {
    public var rawValue: String {
        switch self {
        case let .audio(role): role.rawValue
        case let .video(role): role.rawValue
        case let .caption(role): role.rawValue
        }
    }

    public init?(rawValue: String) {
        // TODO: not ideal
        // to satisfy FCPXMLRole's RawRepresentable requirement we need this init
        // but we can't derive whether the role is audio or video from a raw string,
        // so we have to default to one of them.

        if let videoOrAudioRole = FCPXML.VideoRole(rawValue: rawValue) {
            self = .video(videoOrAudioRole)
            return
        }

        // caption roles, however, have a format that is fundamentally different from audio/video
        // roles.

        if let captionRole = FCPXML.CaptionRole(rawValue: rawValue) {
            self = .caption(captionRole)
            return
        }

        return nil
    }
}

// MARK: - Proxy Properties

extension FCPXML.AnyRole {
    /// Returns the unwrapped role typed as ``FCPXMLRole``.
    public var wrapped: any FCPXMLRole {
        switch self {
        case let .audio(role): role
        case let .video(role): role
        case let .caption(role): role
        }
    }

    /// Returns the main role.
    public var role: String {
        switch self {
        case let .audio(role): role.role
        case let .video(role): role.role
        case let .caption(role): role.role
        }
    }

    /// Returns the sub-role, if present or applicable.
    public var subRole: String? {
        switch self {
        case let .audio(role): role.subRole
        case let .video(role): role.subRole
        case .caption(_): nil
        }
    }
}

extension FCPXML.AnyRole: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case let .audio(role): role.debugDescription
        case let .video(role): role.debugDescription
        case let .caption(role): role.debugDescription
        }
    }
}

#endif
