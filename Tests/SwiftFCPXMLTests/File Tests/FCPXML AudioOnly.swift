//
//  FCPXML AudioOnly.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2022 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

@testable import SwiftFCPXML
import Foundation
import SwiftExtensions
import SwiftTimecodeCore
import Testing
import TestingExtensions

@Suite struct FCPXML_AudioOnly: TestUtils {
    // MARK: - Test Data
    
    var fileContents: Data { get throws {
        try TestResource.FCPXMLExports.audioOnly.data()
    } }
    
    /// Project @ 24fps.
    let projectFrameRate: TimecodeFrameRate = .fps24
    
    // MARK: - Tests
    
    @Test
    func parse() async throws {
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
        #expect(roles.contains(.audio(raw: "music.music-1")!))
        #expect(roles.contains(.audio(raw: "effects")!))
    }
}

#endif
