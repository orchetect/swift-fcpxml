//
//  XML Utilities.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftExtensions

// TODO: forced Sendable conformance
extension XMLElement: @retroactive @unchecked Sendable { }

// MARK: - Ancestor Walking

// TODO: remove or refactor?

extension XMLElement {
    /// Utility:
    /// Walk ancestors of the element.
    package func walkAncestorElements(
        includingSelf: Bool,
        _ block: (_ element: XMLElement) -> Bool
    ) {
        let block: (_ element: XMLElement) -> WalkAncestorsIntermediateResult<Void> = { element in
            if block(element) {
                .continue
            } else {
                .return(withValue: ())
            }
        }
        _ = Self.walkAncestorElements(
            startingWith: includingSelf ? self : parentElement,
            returning: Void.self,
            block
        )
    }

    /// Utility:
    /// Walk ancestors of the element.
    package func walkAncestorElements<T>(
        includingSelf: Bool,
        returning: T.Type,
        _ block: (_ element: XMLElement) -> WalkAncestorsIntermediateResult<T>
    ) -> WalkAncestorsResult<T> {
        Self.walkAncestorElements(
            startingWith: includingSelf ? self : parentElement,
            returning: returning,
            block
        )
    }

    /// Utility Helper:
    /// Walk ancestors of the element.
    private static func walkAncestorElements<T>(
        startingWith element: XMLElement?,
        returning: T.Type,
        _ block: (_ element: XMLElement) -> WalkAncestorsIntermediateResult<T>
    ) -> WalkAncestorsResult<T> {
        guard let element else { return .exhaustedAncestors }

        let blockResult = block(element)

        switch blockResult {
        case .continue:
            guard let parent = element.parentElement else {
                return .exhaustedAncestors
            }
            return walkAncestorElements(startingWith: parent, returning: returning, block)
        case let .return(value):
            return .value(value)
        case .failure:
            return .failure
        }
    }

    package enum WalkAncestorsIntermediateResult<T> {
        case `continue`
        case `return`(withValue: T)
        case failure
    }

    package enum WalkAncestorsResult<T> {
        case exhaustedAncestors
        case value(_ value: T)
        case failure
    }
}

extension XMLElement {
    /// Utility:
    /// Returns ancestor elements beginning from closest ancestor.
    /// If `replacement` is non-nil it will be used instead of the element's ancestors.
    ///
    /// - Parameters:
    ///   - replacement: Optional replacement for ancestors. Ordered nearest to furthest ancestor.
    ///   - includingSelf: Include `self` as the first ancestor.
    /// - Returns: Sequence of ancestors, optionally including `self`.
    package func ancestorElements(
        overrideWith replacement: (some Sequence<XMLElement>)?,
        includingSelf: Bool
    ) -> AnySequence<XMLElement> {
        if let replacement {
            if includingSelf {
                ([self] + replacement).asAnySequence
            } else {
                replacement.asAnySequence
            }
        } else {
            ancestorElements(includingSelf: includingSelf).asAnySequence
        }
    }
}

#endif
