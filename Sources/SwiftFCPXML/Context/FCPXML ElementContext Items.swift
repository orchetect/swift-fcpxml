//
//  FCPXML ElementContext Items.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftTimecodeCore

// MARK: - Built-In Context

extension FCPXML.ElementContext {
    /// The absolute start timecode of the element in seconds.
    public static var absoluteStart: FCPXML.ElementContext<TimeInterval?> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.absoluteStart
        }
    }

    /// The absolute start timecode of the element expressed as timecode.
    public static func absoluteStartAsTimecode(
        frameRateSource: FCPXML.FrameRateSource = .mainTimeline
    ) -> FCPXML.ElementContext<Timecode?> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.absoluteStartAsTimecode(frameRateSource: frameRateSource)
        }
    }

    /// The absolute end timecode of the element in seconds.
    public static var absoluteEnd: FCPXML.ElementContext<TimeInterval?> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.absoluteEnd
        }
    }

    /// The absolute end timecode of the element expressed as timecode.
    public static func absoluteEndAsTimecode(
        frameRateSource: FCPXML.FrameRateSource = .mainTimeline
    ) -> FCPXML.ElementContext<Timecode?> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.absoluteEndAsTimecode(frameRateSource: frameRateSource)
        }
    }

    /// The element's local roles, if applicable or present.
    /// These roles are either attached to the element itself or in some cases are acquired from
    /// the element's contents.
    /// Includes default roles if none are specified and if applicable.
    public static var localRoles: FCPXML.ElementContext<[FCPXML.AnyRole]> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.localRoles(includeDefaultRoles: true)
        }
    }

    /// Returns the effective roles of the element inherited from ancestors.
    /// Includes default roles if none are specified and if applicable.
    public static var inheritedRoles: FCPXML.ElementContext<[FCPXML.AnyInterpolatedRole]> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.inheritedRoles
        }
    }

    /// Returns the occlusion information for the element in relation to its parent.
    public static var occlusion: FCPXML.ElementContext<FCPXML.ElementOcclusion> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.occlusion
        }
    }

    /// Returns the effective occlusion information for the element in relation to the main
    /// timeline.
    public static var effectiveOcclusion: FCPXML.ElementContext<FCPXML.ElementOcclusion> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.effectiveOcclusion
        }
    }

    /// Contains an event name if the element is a descendent of an event.
    public static var ancestorEventName: FCPXML.ElementContext<String?> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.ancestorEventName
        }
    }

    /// Contains a project name if the element is a descendent of a project.
    public static var ancestorProjectName: FCPXML.ElementContext<String?> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.ancestorProjectName
        }
    }

    /// The parent clip's type.
    public static var parentType: FCPXML.ElementContext<FCPXML.ElementType?> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.parentType
        }
    }

    /// The parent clip's name.
    public static var parentName: FCPXML.ElementContext<String?> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.parentName
        }
    }

    /// The parent clip's absolute start time in seconds.
    public static var parentAbsoluteStart: FCPXML.ElementContext<TimeInterval?> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.parentAbsoluteStart
        }
    }

    /// The parent element's absolute start time expressed as timecode.
    public static func parentAbsoluteStartAsTimecode(
        frameRateSource: FCPXML.FrameRateSource = .mainTimeline
    ) -> FCPXML.ElementContext<Timecode?> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.parentAbsoluteStartAsTimecode(frameRateSource: frameRateSource)
        }
    }

    /// The parent clip's absolute end time in seconds.
    public static var parentAbsoluteEnd: FCPXML.ElementContext<TimeInterval?> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.parentAbsoluteEnd
        }
    }

    /// The parent element's absolute end time expressed as timecode.
    public static func parentAbsoluteEndAsTimecode(
        frameRateSource: FCPXML.FrameRateSource = .mainTimeline
    ) -> FCPXML.ElementContext<Timecode?> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.parentAbsoluteEndAsTimecode(frameRateSource: frameRateSource)
        }
    }

    /// The parent clip's duration in seconds.
    public static var parentDuration: FCPXML.ElementContext<TimeInterval?> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.parentDuration
        }
    }

    /// The parent element's duration expressed as timecode.
    public static func parentDurationAsTimecode(
        frameRateSource: FCPXML.FrameRateSource = .mainTimeline
    ) -> FCPXML.ElementContext<Timecode?> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.parentDurationAsTimecode(frameRateSource: frameRateSource)
        }
    }

    /// Returns keywords applied to the element if the element is a clip, otherwise returns keywords applied to the
    /// first ancestor clip.
    public static func keywords(
        constrainToKeywordRanges: Bool = true
    ) -> FCPXML.ElementContext<[FCPXML.Keyword]> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.keywords(constrainToKeywordRanges: constrainToKeywordRanges)
        }
    }

    /// Returns keywords applied to the element if the element is a clip, otherwise returns keywords applied to the
    /// first ancestor clip.
    /// Keywords are flattened to an array of individual keyword strings, trimming leading and
    /// trailing whitespace, removing duplicates and sorting alphabetically.
    public static func keywordsFlat(
        constrainToKeywordRanges: Bool = true
    ) -> FCPXML.ElementContext<[String]> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.keywordsFlat(constrainToKeywordRanges: constrainToKeywordRanges)
        }
    }

    /// Returns metadata applicable to the element.
    public static var metadata: FCPXML.ElementContext<[FCPXML.Metadata.Metadatum]> {
        FCPXML.ElementContext { _, _, _, tools in
            tools.metadata
        }
    }
}

#endif
