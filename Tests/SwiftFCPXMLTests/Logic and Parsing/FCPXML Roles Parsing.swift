//
//  FCPXML Roles Parsing.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import SwiftExtensions
@testable import SwiftFCPXML
import Testing

@Suite
struct FCPXML_RolesParsing: TestUtils {
    /// Standard role (audio or video)
    @Test
    func parseRawStandardRole() throws {
        let parse = FCPXML._parseRawStandardRole(rawValue:)

        // Should parse
        #expect(try parse("Main").role == "Main")
        #expect(try parse("Main").subRole == nil)

        #expect(try parse("Main.Main-1").role == "Main")
        #expect(try parse("Main.Main-1").subRole == "Main-1")

        #expect(try parse("Main.Sub").role == "Main")
        #expect(try parse("Main.Sub").subRole == "Sub")

        #expect(
            try parse("Hellõ țhiș is ǎ maīn) role 😀.This is a 👋 sub role").role
                == "Hellõ țhiș is ǎ maīn) role 😀"
        )
        #expect(
            try parse("Hellõ țhiș is ǎ maīn) role 😀.This is a 👋 sub role").subRole
                == "This is a 👋 sub role"
        )

        // Shouldn't parse
        #expect(throws: (any Error).self) { try parse(".") }
        #expect(throws: (any Error).self) { try parse("..") }
        #expect(throws: (any Error).self) { try parse(".-") }
        #expect(throws: (any Error).self) { try parse(".-1") }
        #expect(throws: (any Error).self) { try parse("Main.") }
        #expect(throws: (any Error).self) { try parse(".Sub") }
        #expect(throws: (any Error).self) { try parse(".Sub-1") }
        #expect(throws: (any Error).self) { try parse("Main.Main.") }
        #expect(throws: (any Error).self) { try parse("Main.Main.Main-1") }
        #expect(throws: (any Error).self) { try parse("iTT?captionFormat=ITT.en") }
        #expect(throws: (any Error).self) { try parse("?=") }
    }

    /// Closed caption role
    @Test
    func parseRawCaptionRole() throws {
        let parse = FCPXML._parseRawCaptionRole(rawValue:)

        // Should parse
        #expect(try parse("iTT?captionFormat=ITT.en").role == "iTT")
        #expect(try parse("iTT?captionFormat=ITT.en").captionFormat == "ITT.en")

        #expect(try parse("Markers?captionFormat=ITT.en").role == "Markers")
        #expect(try parse("Markers?captionFormat=ITT.en").captionFormat == "ITT.en")

        #expect(
            try parse("Hellõ țhiș is ǎ capīion role 😀?captionFormat=ITT.en").role
                == "Hellõ țhiș is ǎ capīion role 😀"
        )
        #expect(
            try parse("Hellõ țhiș is ǎ capīion role 😀?captionFormat=ITT.en").captionFormat
                == "ITT.en"
        )

        // Shouldn't parse
        #expect(throws: (any Error).self) { try parse("captionFormat=ITT.en") }
        #expect(throws: (any Error).self) { try parse("iTT?captionFormat") }
        #expect(throws: (any Error).self) { try parse("?=") }
        #expect(throws: (any Error).self) { try parse("Main") }
        #expect(throws: (any Error).self) { try parse("Main.Main-1") }
        #expect(throws: (any Error).self) { try parse("Main.Sub") }
        #expect(throws: (any Error).self) { try parse("Hellõ țhiș is ǎ maīn) role 😀.This is a 👋 sub role") }
        #expect(throws: (any Error).self) { try parse(".") }
        #expect(throws: (any Error).self) { try parse("..") }
        #expect(throws: (any Error).self) { try parse(".-") }
        #expect(throws: (any Error).self) { try parse(".-1") }
        #expect(throws: (any Error).self) { try parse("Main.") }
        #expect(throws: (any Error).self) { try parse(".Sub") }
        #expect(throws: (any Error).self) { try parse(".Sub-1") }
        #expect(throws: (any Error).self) { try parse("Main.Main.") }
        #expect(throws: (any Error).self) { try parse("Main.Main.Main") }
    }

    @Test
    func collapseStandardSubRole() {
        let collapse = FCPXML._collapseStandardSubRole(role:subRole:)

        #expect(collapse("Main", nil).role == "Main")
        #expect(collapse("Main", nil).subRole == nil)

        // empty sub-role
        #expect(collapse("Main", "").role == "Main")
        #expect(collapse("Main", "").subRole == nil)

        // whitespace-only sub-role
        #expect(collapse("Main", " ").role == "Main")
        #expect(collapse("Main", " ").subRole == nil)

        #expect(collapse("Main", "Main-1").role == "Main")
        #expect(collapse("Main", "Main-1").subRole == nil)

        #expect(collapse("Main", "Main-20").role == "Main")
        #expect(collapse("Main", "Main-20").subRole == nil)

        #expect(collapse("Main", "SubRole").role == "Main")
        #expect(collapse("Main", "SubRole").subRole == "SubRole")

        #expect(collapse("Main", "SubRole-20").role == "Main")
        #expect(collapse("Main", "SubRole-20").subRole == "SubRole-20")
    }

    @Test
    func isSMainRoleBuiltIn_Video() throws {
        func VR(rawValue: String) throws -> FCPXML.VideoRole {
            try #require(FCPXML.VideoRole(rawValue: rawValue))
        }

        #expect(try !VR(rawValue: "custom").isMainRoleBuiltIn)
        #expect(try !VR(rawValue: "custom.custom").isMainRoleBuiltIn)
        #expect(try !VR(rawValue: "custom.custom-1").isMainRoleBuiltIn)
        #expect(try !VR(rawValue: "custom.video-1").isMainRoleBuiltIn)

        #expect(try VR(rawValue: "video").isMainRoleBuiltIn)
        #expect(try VR(rawValue: "video.video-1").isMainRoleBuiltIn)
        #expect(try VR(rawValue: "video.custom").isMainRoleBuiltIn)

        #expect(try VR(rawValue: "Video").isMainRoleBuiltIn)
        #expect(try VR(rawValue: "Video.Video-1").isMainRoleBuiltIn)
        #expect(try VR(rawValue: "Video.custom").isMainRoleBuiltIn)

        #expect(try VR(rawValue: "titles").isMainRoleBuiltIn)
        #expect(try VR(rawValue: "titles.titles-1").isMainRoleBuiltIn)
        #expect(try VR(rawValue: "titles.custom").isMainRoleBuiltIn)

        #expect(try VR(rawValue: "Titles").isMainRoleBuiltIn)
        #expect(try VR(rawValue: "Titles.Titles-1").isMainRoleBuiltIn)
        #expect(try VR(rawValue: "Titles.custom").isMainRoleBuiltIn)
    }

    @Test
    func isSMainRoleBuiltIn_Audio() throws {
        func AR(rawValue: String) throws -> FCPXML.AudioRole {
            try #require(FCPXML.AudioRole(rawValue: rawValue))
        }

        #expect(try !AR(rawValue: "custom").isMainRoleBuiltIn)
        #expect(try !AR(rawValue: "custom.custom").isMainRoleBuiltIn)
        #expect(try !AR(rawValue: "custom.custom-1").isMainRoleBuiltIn)
        #expect(try !AR(rawValue: "custom.dialogue-1").isMainRoleBuiltIn)

        #expect(try AR(rawValue: "dialogue").isMainRoleBuiltIn)
        #expect(try AR(rawValue: "dialogue.dialogue-1").isMainRoleBuiltIn)
        #expect(try AR(rawValue: "dialogue.custom").isMainRoleBuiltIn)

        #expect(try AR(rawValue: "Dialogue").isMainRoleBuiltIn)
        #expect(try AR(rawValue: "Dialogue.Dialogue-1").isMainRoleBuiltIn)
        #expect(try AR(rawValue: "Dialogue.custom").isMainRoleBuiltIn)

        #expect(try AR(rawValue: "effects").isMainRoleBuiltIn)
        #expect(try AR(rawValue: "effects.effects-1").isMainRoleBuiltIn)
        #expect(try AR(rawValue: "effects.custom").isMainRoleBuiltIn)

        #expect(try AR(rawValue: "Effects").isMainRoleBuiltIn)
        #expect(try AR(rawValue: "Effects.Effects-1").isMainRoleBuiltIn)
        #expect(try AR(rawValue: "Effects.custom").isMainRoleBuiltIn)

        #expect(try AR(rawValue: "music").isMainRoleBuiltIn)
        #expect(try AR(rawValue: "music.music-1").isMainRoleBuiltIn)
        #expect(try AR(rawValue: "music.custom").isMainRoleBuiltIn)

        #expect(try AR(rawValue: "Music").isMainRoleBuiltIn)
        #expect(try AR(rawValue: "Music.Music-1").isMainRoleBuiltIn)
        #expect(try AR(rawValue: "Music.custom").isMainRoleBuiltIn)
    }

    @Test
    func isSMainRoleBuiltIn_Caption() throws {
        func CR(rawValue: String) throws -> FCPXML.CaptionRole {
            try #require(FCPXML.CaptionRole(rawValue: rawValue))
        }

        #expect(try !CR(rawValue: "custom?captionFormat=ITT.en").isMainRoleBuiltIn)
        #expect(try !CR(rawValue: "video?captionFormat=ITT.en").isMainRoleBuiltIn)
        #expect(try !CR(rawValue: "titles?captionFormat=ITT.en").isMainRoleBuiltIn)
        #expect(try !CR(rawValue: "dialogue?captionFormat=ITT.en").isMainRoleBuiltIn)
        #expect(try !CR(rawValue: "effects?captionFormat=ITT.en").isMainRoleBuiltIn)
        #expect(try !CR(rawValue: "music?captionFormat=ITT.en").isMainRoleBuiltIn)

        #expect(try CR(rawValue: "iTT?captionFormat=ITT.en").isMainRoleBuiltIn)
        #expect(try CR(rawValue: "SRT?captionFormat=ITT.en").isMainRoleBuiltIn)
        #expect(try CR(rawValue: "CEA-608?captionFormat=ITT.en").isMainRoleBuiltIn)
    }

    @Test
    func lowercased() throws {
        func AR(rawValue: String) throws -> FCPXML.AudioRole {
            try #require(FCPXML.AudioRole(rawValue: rawValue))
        }

        #expect(try AR(rawValue: "dialogue").lowercased(derivedOnly: false).rawValue == "dialogue")
        #expect(try AR(rawValue: "Dialogue").lowercased(derivedOnly: false).rawValue == "dialogue")
        #expect(try AR(rawValue: "DIALOGUE").lowercased(derivedOnly: false).rawValue == "dialogue")

        #expect(try AR(rawValue: "dialogue.dialogue-1").lowercased(derivedOnly: false).rawValue == "dialogue.dialogue-1")
        #expect(try AR(rawValue: "Dialogue.Dialogue-1").lowercased(derivedOnly: false).rawValue == "dialogue.dialogue-1")
        #expect(try AR(rawValue: "DIALOGUE.DIALOGUE-1").lowercased(derivedOnly: false).rawValue == "dialogue.dialogue-1")

        #expect(try AR(rawValue: "dialogue.mixl").lowercased(derivedOnly: false).rawValue == "dialogue.mixl")
        #expect(try AR(rawValue: "dialogue.MixL").lowercased(derivedOnly: false).rawValue == "dialogue.mixl")
        #expect(try AR(rawValue: "Dialogue.MixL").lowercased(derivedOnly: false).rawValue == "dialogue.mixl")
        #expect(try AR(rawValue: "DIALOGUE.MIXL").lowercased(derivedOnly: false).rawValue == "dialogue.mixl")
    }

    @Test
    func lowercased_DerivedOnly() throws {
        func AR(rawValue: String) throws -> FCPXML.AudioRole {
            try #require(FCPXML.AudioRole(rawValue: rawValue))
        }

        #expect(try AR(rawValue: "dialogue").lowercased(derivedOnly: true).rawValue == "dialogue")
        #expect(try AR(rawValue: "Dialogue").lowercased(derivedOnly: true).rawValue == "dialogue")
        #expect(try AR(rawValue: "DIALOGUE").lowercased(derivedOnly: true).rawValue == "dialogue")

        #expect(try AR(rawValue: "dialogue.dialogue-1").lowercased(derivedOnly: true).rawValue == "dialogue.dialogue-1")
        #expect(try AR(rawValue: "Dialogue.Dialogue-1").lowercased(derivedOnly: true).rawValue == "dialogue.dialogue-1")
        #expect(try AR(rawValue: "DIALOGUE.DIALOGUE-1").lowercased(derivedOnly: true).rawValue == "dialogue.dialogue-1")

        #expect(try AR(rawValue: "dialogue.mixl").lowercased(derivedOnly: true).rawValue == "dialogue.mixl")
        #expect(try AR(rawValue: "dialogue.MixL").lowercased(derivedOnly: true).rawValue == "dialogue.MixL")
        #expect(try AR(rawValue: "Dialogue.MixL").lowercased(derivedOnly: true).rawValue == "dialogue.MixL")
        #expect(try AR(rawValue: "DIALOGUE.MIXL").lowercased(derivedOnly: true).rawValue == "dialogue.MIXL")
    }

    @Test
    func titleCased() throws {
        func AR(rawValue: String) throws -> FCPXML.AudioRole {
            try #require(FCPXML.AudioRole(rawValue: rawValue))
        }

        #expect(try AR(rawValue: "dialogue").titleCased(derivedOnly: false).rawValue == "Dialogue")
        #expect(try AR(rawValue: "Dialogue").titleCased(derivedOnly: false).rawValue == "Dialogue")
        #expect(try AR(rawValue: "DIALOGUE").titleCased(derivedOnly: false).rawValue == "Dialogue")

        #expect(try AR(rawValue: "dialogue.dialogue-1").titleCased(derivedOnly: false).rawValue == "Dialogue.Dialogue-1")
        #expect(try AR(rawValue: "Dialogue.Dialogue-1").titleCased(derivedOnly: false).rawValue == "Dialogue.Dialogue-1")
        #expect(try AR(rawValue: "DIALOGUE.DIALOGUE-1").titleCased(derivedOnly: false).rawValue == "Dialogue.Dialogue-1")

        #expect(try AR(rawValue: "dialogue.mixl").titleCased(derivedOnly: false).rawValue == "Dialogue.Mixl")
        #expect(try AR(rawValue: "dialogue.MixL").titleCased(derivedOnly: false).rawValue == "Dialogue.Mixl") // TODO: not ideal
        #expect(try AR(rawValue: "Dialogue.MixL").titleCased(derivedOnly: false).rawValue == "Dialogue.Mixl") // TODO: not ideal
        #expect(try AR(rawValue: "DIALOGUE.MIXL").titleCased(derivedOnly: false).rawValue == "Dialogue.Mixl") // TODO: not ideal
    }

    @Test
    func titleCased_DerivedOnly() throws {
        func AR(rawValue: String) throws -> FCPXML.AudioRole {
            try #require(FCPXML.AudioRole(rawValue: rawValue))
        }

        #expect(try AR(rawValue: "dialogue").titleCased(derivedOnly: true).rawValue == "Dialogue")
        #expect(try AR(rawValue: "Dialogue").titleCased(derivedOnly: true).rawValue == "Dialogue")
        #expect(try AR(rawValue: "DIALOGUE").titleCased(derivedOnly: true).rawValue == "Dialogue")

        #expect(try AR(rawValue: "dialogue.dialogue-1").titleCased(derivedOnly: true).rawValue == "Dialogue.Dialogue-1")
        #expect(try AR(rawValue: "Dialogue.Dialogue-1").titleCased(derivedOnly: true).rawValue == "Dialogue.Dialogue-1")
        #expect(try AR(rawValue: "DIALOGUE.DIALOGUE-1").titleCased(derivedOnly: true).rawValue == "Dialogue.Dialogue-1")

        #expect(try AR(rawValue: "dialogue.mixl").titleCased(derivedOnly: true).rawValue == "Dialogue.mixl")
        #expect(try AR(rawValue: "dialogue.MixL").titleCased(derivedOnly: true).rawValue == "Dialogue.MixL")
        #expect(try AR(rawValue: "Dialogue.MixL").titleCased(derivedOnly: true).rawValue == "Dialogue.MixL")
        #expect(try AR(rawValue: "DIALOGUE.MIXL").titleCased(derivedOnly: true).rawValue == "Dialogue.MIXL")
    }

    @Test
    func isSubRoleDerivedFromMainRole() {
        let isDerived = FCPXML._isSubRole(_:derivedFromMainRole:)

        #expect(!isDerived(nil, "Dialogue"))
        #expect(!isDerived("", "Dialogue"))
        #expect(!isDerived(" ", "Dialogue"))
        #expect(!isDerived("Dial", "Dialogue"))
        #expect(!isDerived("Video", "Dialogue"))

        #expect(isDerived("Dialogue", "Dialogue"))
        #expect(isDerived("Dialogue-1", "Dialogue"))
    }
}

#endif
