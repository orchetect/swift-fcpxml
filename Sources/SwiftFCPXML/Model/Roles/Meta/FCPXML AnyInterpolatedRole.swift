//
//  FCPXML AnyInterpolatedRole.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2022 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation

extension FCPXML {
    /// Type-erased box containing a specialized interpolated role instance.
    public enum AnyInterpolatedRole: Equatable, Hashable, Sendable {
        /// Element's role is a custom role assigned by the user.
        case assigned(AnyRole)
        
        /// Element's role is a defaulted role and no role is assigned either to the element or any
        /// of its ancestors.
        case defaulted(AnyRole)
        
        /// Role is not assigned to the element, but is inherited from an ancestor whose role was
        /// assigned by the user.
        case inherited(AnyRole)
    }
}

extension FCPXML.AnyInterpolatedRole: FCPXMLRole {
    public var roleType: FCPXML.RoleType {
        wrapped.roleType
    }
    
    public func asAnyRole() -> FCPXML.AnyRole {
        wrapped.asAnyRole()
    }
    
    public func lowercased(derivedOnly: Bool) -> Self {
        let anyRole = wrapped.lowercased(derivedOnly: derivedOnly)
        return rewrap(newRole: anyRole)
    }
    
    public func titleCased(derivedOnly: Bool) -> Self {
        let anyRole = wrapped.titleCased(derivedOnly: derivedOnly)
        return rewrap(newRole: anyRole)
    }
    
    public func titleCasedDefaultRole(derivedOnly: Bool) -> Self {
        let anyRole = wrapped.titleCasedDefaultRole(derivedOnly: derivedOnly)
        return rewrap(newRole: anyRole)
    }
    
    public var isMainRoleBuiltIn: Bool {
        wrapped.isMainRoleBuiltIn
    }
    
    public init?(rawValue: String) {
        guard let anyRole = FCPXML.AnyRole(rawValue: rawValue)
        else { return nil }
        
        // TODO: assigned case is best default case, but not ideal
        self = .assigned(anyRole)
    }
    
    public var rawValue: String {
        wrapped.rawValue
    }
}

extension FCPXML.AnyInterpolatedRole {
    public func collapsingSubRole() -> Self {
        let anyRole = wrapped.collapsingSubRole()
        return rewrap(newRole: anyRole)
    }
}

extension FCPXML.AnyInterpolatedRole {
    public var wrapped: FCPXML.AnyRole {
        switch self {
        case let .assigned(role): return role
        case let .defaulted(role): return role
        case let .inherited(role): return role
        }
    }
}

extension FCPXML.AnyInterpolatedRole {
    /// Returns `true` if the interpolated case is ``FCPXML/AnyInterpolatedRole/assigned(_:)``.
    public var isAssigned: Bool {
        guard case .assigned = self else { return false }
        return true
    }
    
    /// Returns `true` if the interpolated case is ``FCPXML/AnyInterpolatedRole/defaulted(_:)``.
    public var isDefaulted: Bool {
        guard case .defaulted = self else { return false }
        return true
    }
    
    /// Returns `true` if the interpolated case is ``FCPXML/AnyInterpolatedRole/inherited(_:)``.
    public var isInherited: Bool {
        guard case .inherited = self else { return false }
        return true
    }
}

extension FCPXML.AnyInterpolatedRole: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case let .assigned(role): return "assigned(\(role.debugDescription))"
        case let .defaulted(role): return "defaulted(\(role.debugDescription))"
        case let .inherited(role): return "inherited(\(role.debugDescription))"
        }
    }
}

// MARK: - Helpers

extension FCPXML.AnyInterpolatedRole {
    fileprivate func rewrap(newRole: FCPXML.AnyRole) -> Self {
        switch self {
        case .assigned: return .assigned(newRole)
        case .defaulted: return .defaulted(newRole)
        case .inherited: return .inherited(newRole)
        }
    }
}

#endif
