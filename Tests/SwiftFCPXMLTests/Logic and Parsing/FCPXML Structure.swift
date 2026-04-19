//
//  FCPXML Structure.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftExtensions
import SwiftFCPXML
import SwiftTimecodeCore
import Testing
import TestingExtensions

@Suite
struct FCPXML_Structure: TestUtils {
    /// Ensure that elements that can appear in various locations in the XML hierarchy are all found.
    @Test
    func parse() throws {
        // load file

        let rawData = try TestResource.FCPXMLExports.structure.data()

        // load

        let fcpxml = try FCPXML(fileContent: rawData)

        // events

        let events = Set(fcpxml.allEvents().map(\.name))
        #expect(events == ["Test Event", "Test Event 2"])

        // projects

        let projects = Set(fcpxml.allProjects().map(\.name))
        #expect(projects == ["Test Project", "Test Project 2", "Test Project 3"])

        // TODO: it may be possible for story elements (sequence, clips, etc.) to be in the root `fcpxml` element
        // the docs say that they can be there as browser elements
        // test parsing them? might need a new method to get them specifically like `FCPXML.parseStoryElementsInRoot()`
    }
}

#endif
