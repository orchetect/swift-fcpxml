//
//  FCPXML Library Tests.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftExtensions
@testable import SwiftFCPXML
import SwiftTimecodeCore
import Testing

@Suite
struct FCPXML_Library: TestUtils {
    @Test
    func location() throws {
        let url = try #require(URL(string: "file:///Users/user/Movies/MyLibrary.fcpbundle/"))
        let library = FCPXML.Library(location: url)

        #expect(library.location == url)
    }

    @Test
    func name() throws {
        let url = try #require(URL(string: "file:///Users/user/Movies/MyLibrary.fcpbundle/"))
        let library = FCPXML.Library(location: url)

        #expect(library.name == "MyLibrary")
    }
}

#endif
