//
//  FinalCutPro FCPXML RolesList.swift
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

@Suite struct FinalCutPro_FCPXML_RolesList: TestUtils {
    // MARK: - Test Data
    
    var fileContents: Data { get throws {
        try TestResource.FCPXMLExports.rolesList.data()
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
        
        // skip testing file contents, we only care about roles extraction
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
        
        // dump(roles)
        
        #expect(roles.count == 4)
        #expect(roles.contains(.video(raw: "Video")!))
        #expect(roles.contains(.video(raw: "FIXING.FIXING-1")!))
        #expect(roles.contains(.video(raw: "TO-DO.TO-DO-1")!))
        #expect(roles.contains(.video(raw: "VFX.VFX-1")!))
    }
}

#endif
