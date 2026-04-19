//
//  FCPXML AudioOnly.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftExtensions
@testable import SwiftFCPXML
import SwiftTimecodeCore
import Testing
import TestingExtensions

@Suite
struct FCPXML_AudioOnly: TestUtils {
    // MARK: - Test Data

    var fileContents: Data {
        get throws {
            try TestResource.FCPXMLExports.audioOnly.data()
        }
    }

    /// Project @ 24fps.
    let projectFrameRate: TimecodeFrameRate = .fps24

    // MARK: - Tests

    @Test
    func parse() throws {
        // load
        let rawData = try fileContents
        let fcpxml = try FCPXML(fileContent: rawData)

        // version
        #expect(fcpxml.version == .ver1_11)

        // skip testing file contents
    }

    @Test
    func extractMarkers() async throws {
        // load file
        let rawData = try fileContents

        // load
        let fcpxml = try FCPXML(fileContent: rawData)

        // project
        let project = try #require(fcpxml.allProjects().first)

        let extractedMarkers = await project
            .extract(preset: .markers, scope: .mainTimeline)
            .sortedByAbsoluteStartTimecode()
            // .zeroIndexed // not necessary after sorting - sort returns new array

        let markers = extractedMarkers

        let expectedMarkerCount = 10
        #expect(markers.count == expectedMarkerCount)

        // print("Markers sorted by absolute timecode:")
        // print(Self.debugString(for: markers))
    }

    @Test
    func extractRoles() async throws {
        // load file
        let rawData = try fileContents

        // load
        let fcpxml = try FCPXML(fileContent: rawData)

        // project
        let project = try #require(fcpxml.allProjects().first)

        let roles = await project.extract(
            preset: .roles(roleTypes: .allCases),
            scope: .deep(auditions: .active, mcClipAngles: .active)
        )

        dump(roles)

        #expect(roles.count == 2)
        #expect(try roles.contains(#require(.audio(raw: "music.music-1"))))
        #expect(try roles.contains(#require(.audio(raw: "effects"))))
    }
}

#endif
