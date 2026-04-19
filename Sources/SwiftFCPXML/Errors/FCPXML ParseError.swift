//
//  FCPXML ParseError.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

extension FCPXML {
    /// Final Cut Pro FCPXML file parsing error.
    public enum ParseError: Error {
        case general(String)
    }
}

#endif
