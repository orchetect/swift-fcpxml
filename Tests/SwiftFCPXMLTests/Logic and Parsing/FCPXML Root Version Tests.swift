//
//  FCPXML Root Version Tests.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import SwiftExtensions
import SwiftFCPXML
import SwiftTimecodeCore
import Testing

@Suite
struct FCPXML_RootVersionTests: TestUtils {
    typealias Version = FCPXML.Version

    @Test
    func version_1_12() {
        let v = Version(1, 12)

        #expect(v.major == 1)
        #expect(v.minor == 12)
        #expect(v.patch == 0)
        #expect(v.semanticVersion.build == nil)
        #expect(v.semanticVersion.preRelease == nil)

        #expect(v.rawValue == "1.12")
    }

    @Test
    func version_1_12_1() {
        let v = Version(1, 12, 1)

        #expect(v.major == 1)
        #expect(v.minor == 12)
        #expect(v.patch == 1)
        #expect(v.semanticVersion.build == nil)
        #expect(v.semanticVersion.preRelease == nil)

        #expect(v.rawValue == "1.12.1")
    }

    @Test
    func version_Equatable() {
        #expect(Version(1, 12) == Version(1, 12))
        #expect(Version(1, 12) != Version(1, 13))
        #expect(Version(1, 12) != Version(2, 12))
    }

    @Test
    func version_Comparable() {
        #expect(
            !(Version(1, 12) < Version(1, 12))
        )

        #expect(
            !(Version(1, 12) > Version(1, 12))
        )

        #expect(
            Version(1, 11) < Version(1, 12)
        )

        #expect(
            Version(1, 12) > Version(1, 11)
        )

        #expect(
            Version(1, 10) < Version(2, 3)
        )

        #expect(
            Version(2, 3) > Version(1, 10)
        )
    }

    @Test
    func version_RawValue_EdgeCase_MajorVersionOnly() throws {
        let v = try #require(Version(rawValue: "2"))

        #expect(v.major == 2)
        #expect(v.minor == 0)
        #expect(v.patch == 0)
        #expect(v.semanticVersion.build == nil)
        #expect(v.semanticVersion.preRelease == nil)

        #expect(v.rawValue == "2.0")
    }

    @Test
    func version_RawValue_Invalid() {
        #expect(Version(rawValue: "") == nil)
        #expect(Version(rawValue: "1.") == nil)
        #expect(Version(rawValue: "1.A") == nil)
        #expect(Version(rawValue: "A") == nil)
        #expect(Version(rawValue: "A.1") == nil)
        #expect(Version(rawValue: "A.A") == nil)
        #expect(Version(rawValue: "A.A.A") == nil)
        #expect(Version(rawValue: "1.12.") == nil)
        #expect(Version(rawValue: "1.12.A") == nil)
    }

    @Test
    func version_Init_RawValue() throws {
        let v = try #require(Version(rawValue: "1.12"))

        #expect(v.major == 1)
        #expect(v.minor == 12)
    }

    @Test
    func version_RawValue() throws {
        let v = try #require(Version(rawValue: "1.12"))

        #expect(v.rawValue == "1.12")
    }
}

#endif
