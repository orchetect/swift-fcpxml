//
//  Swift Extensions.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2022 Steffan Andrews • Licensed under MIT License
//

extension Sequence {
    /// Wraps the sequence in a `AnySequence` instance.
    package var asAnySequence: AnySequence<Element> {
        AnySequence(self)
    }
}
