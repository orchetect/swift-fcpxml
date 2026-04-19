//
//  FCPXML AncestorRoles.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftExtensions

extension FCPXML {
    /// Describes ancestors of an element and their interpolated roles.
    public struct AncestorRoles: Equatable, Hashable, Sendable {
        /// Element roles, ordered from nearest to furthest ancestor.
        public var elements: [ElementRoles]

        public init(elements: [ElementRoles] = []) {
            self.elements = elements
        }
    }
}

extension FCPXML.AncestorRoles {
    /// Describes an ancestor element and its interpolated roles.
    public struct ElementRoles: Equatable, Hashable, Sendable {
        public var elementType: FCPXML.ElementType
        public var roles: [FCPXML.AnyInterpolatedRole]

        public init(
            elementType: FCPXML.ElementType,
            roles: [FCPXML.AnyInterpolatedRole] = []
        ) {
            self.elementType = elementType
            self.roles = roles
        }
    }
}

extension FCPXML.AncestorRoles {
    /// Flattens all ancestor roles to produce a set of effective inherited roles for an element.
    /// Includes the source of the role inheritance interpolation.
    public func flattenedInterpolatedRoles() -> [FCPXML.AnyInterpolatedRole] {
        var outputRoles: [FCPXML.AnyInterpolatedRole] = []

        let elementVideoRoles = elements.map { $0.roles.videoRoles() }
        let videoRoles = _flatten(singleRoleType: elementVideoRoles)
        if let videoRole = videoRoles.last { // only allow one video role
            outputRoles.append(videoRole)
        }
        let elementAudioRoles = elements.map { $0.roles.audioRoles() }
        let audioRoles = _flatten(singleRoleType: elementAudioRoles)
        outputRoles.append(contentsOf: audioRoles)

        let elementCaptionRoles = elements.map { $0.roles.captionRoles() }
        let captionRoles = _flatten(singleRoleType: elementCaptionRoles)
        outputRoles.append(contentsOf: captionRoles)

        outputRoles.removeDuplicates()

        return outputRoles
    }

    /// Flattens all ancestor roles to produce a set of effective inherited roles for an element.
    public func flattenedRoles() -> [FCPXML.AnyRole] {
        flattenedInterpolatedRoles().map(\.wrapped)
    }

    /// Only supply a collection containing roles of the same type, ie: only `.audio()` roles.
    /// This favors assigned roles and prevents defaulted roles from overriding them.
    func _flatten(
        singleRoleType elementsRoles: [[FCPXML.AnyInterpolatedRole]]
    ) -> [FCPXML.AnyInterpolatedRole] {
        var effectiveRoles: [FCPXML.AnyInterpolatedRole] = []

        func containsAssignedOrInherited(_ roles: [FCPXML.AnyInterpolatedRole]) -> Bool {
            roles.contains(where: \.isAssigned) ||
            roles.contains(where: \.isInherited)
        }

        // it's possible for an element to have more than one valid audio role.
        // ie: `sync-clip` can have `sync-source` with more than one `audio-role-source`
        // and FCP shows them all in a comma-separated list for Audio Role,
        // ie: "Dialogue.MixL" and "Dialogue.MixR" shown in GUI as "MixL, MixR" for Audio Role
        // but both roles are selected in the drop-down role menu of course.
        for elementRoles in elementsRoles.reversed() {
            if containsAssignedOrInherited(elementRoles) {
                effectiveRoles.removeAll()
            }

            for role in elementRoles {
                switch role {
                case .assigned, .inherited:
                    effectiveRoles.append(role)
                case .defaulted:
                    if !containsAssignedOrInherited(effectiveRoles) {
                        effectiveRoles.append(role)
                    }
                }
            }
        }

        return effectiveRoles
    }
}

// MARK: - FCPXML Parsing

extension XMLElement {
    /// FCPXML: Analyzes an element and its ancestors and returns typed information about their roles.
    ///
    /// Ancestors are ordered nearest to furthest.
    func _fcpInheritedRoles(
        ancestors: [XMLElement],
        resources: XMLElement? = nil,
        auditions: FCPXML.Audition.AuditionMask, // = .activeAudition
        mcClipAngles: FCPXML.MCClip.AngleMask // = .active
    ) -> FCPXML.AncestorRoles {
        var ancestorRoles = FCPXML.AncestorRoles()

        // reversed to get ordering of furthest ancestor to closest
        let elements = ([self] + ancestors).reversed()

        // print(elements.map(\.name!))

        // iterate from furthest ancestor to closest
        for index in elements.indices {
            let breadcrumb = elements[index]
            let isLastElement = index == elements.indices.last // self
            var bcRoles = breadcrumb._fcpLocalRoles(
                resources: resources,
                auditions: auditions,
                mcClipAngles: mcClipAngles
            )

            guard let bcType = breadcrumb.fcpElementType else { continue }

            bcRoles = FCPXML.addDefaultRoles(for: bcType, to: bcRoles)

            // differentiate assigned ancestor roles
            if !isLastElement {
                bcRoles = bcRoles._fcpReplacingAssignedRolesWithInherited()
            }

            if !bcRoles.isEmpty {
                let elementRoles = FCPXML.AncestorRoles.ElementRoles(
                    elementType: bcType,
                    roles: bcRoles
                )
                ancestorRoles.elements.insert(elementRoles, at: 0)
            }
        }

        // special case: <title> element can never have audio role(s)
        let clip = fcpAncestorClip(ancestors: ancestors, includingSelf: true)
        if clip?.fcpElementType == .title {
            // remove all audio roles from the hierarchy
            for index in ancestorRoles.elements.indices {
                ancestorRoles.elements[index].roles.removeAll { $0.isAudio }
            }
        }

        // print(ancestorRoles.elements.map {
        //     $0.elementType.rawValue + ": " + $0.roles.map(\.wrapped).map(\.rawValue).joined(separator: " - ")
        // })

        return ancestorRoles
    }
}

extension Sequence<FCPXML.AnyInterpolatedRole> {
    /// Replaces any non-nil roles wrapped in `assigned` cases and re-wraps them in an `inherited`
    /// case instead.
    func _fcpReplacingAssignedRolesWithInherited() -> [Element] {
        let roles: [FCPXML.AnyInterpolatedRole] = map {
            switch $0 {
            case let .assigned(role):
                .inherited(role)
            default:
                $0
            }
        }
        return roles
    }
}

extension FCPXML.AncestorRoles.ElementRoles {
    /// Replaces any non-nil roles wrapped in `assigned` cases and re-wraps them in an `inherited`
    /// case instead.
    func _fcpReplacingAssignedRolesWithInherited() -> Self {
        Self(
            elementType: elementType,
            roles: roles._fcpReplacingAssignedRolesWithInherited()
        )
    }
}

#endif
