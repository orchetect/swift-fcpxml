//
//  FCPXML Time Utilities.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2022 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftExtensions
import SwiftTimecodeCore

// MARK: - Static

/// Collection of methods and structures related to Final Cut Pro.
/// Do not instance; use methods within directly.
extension FCPXML {
    /// `Timecode` setting for `.subFramesBase`.
    /// Final Cut Pro uses 80 subframes per frame.
    public static let timecodeSubFramesBase: Timecode.SubFramesBase = .max80SubFrames
    
    /// `Timecode` setting for `.upperLimit`.
    /// Final Cut Pro is confined to a 24-hour SMPTE timecode clock.
    public static let timecodeUpperLimit: Timecode.UpperLimit = .max24Hours
    
    /// `Timecode` setting for `.stringFormat`.
    public static let timecodeStringFormat: Timecode.StringFormat = []
}

// MARK: - Public Utility Methods

extension FCPXML {
    /// `Timecode` template.
    public static func formTimecode(
        at rate: TimecodeFrameRate
    ) -> Timecode {
        Timecode(
            .zero,
            at: rate,
            base: timecodeSubFramesBase,
            limit: timecodeUpperLimit
        )
    }
    
    /// `Timecode` template.
    public static func formTimecode(
        rational: Fraction,
        at rate: TimecodeFrameRate
    ) throws -> Timecode {
        try Timecode(
            .rational(rational),
            at: rate,
            base: timecodeSubFramesBase,
            limit: timecodeUpperLimit
        )
    }
    
    /// `Timecode` template.
    public static func formTimecode(
        realTime seconds: TimeInterval,
        at rate: TimecodeFrameRate
    ) throws -> Timecode {
        try Timecode(
            .realTime(seconds: seconds),
            at: rate,
            base: timecodeSubFramesBase,
            limit: timecodeUpperLimit
        )
    }
    
    /// `TimecodeInterval` template.
    public static func formTimecodeInterval(
        at rate: TimecodeFrameRate
    ) -> TimecodeInterval {
        let tc = formTimecode(at: rate)
        return TimecodeInterval(tc)
    }
    
    /// `TimecodeInterval` template.
    public static func formTimecodeInterval(
        realTime: TimeInterval,
        at rate: TimecodeFrameRate
    ) throws -> TimecodeInterval {
        
        try TimecodeInterval(
            realTime: realTime,
            at: rate,
            base: timecodeSubFramesBase,
            limit: timecodeUpperLimit
        )
    }
    
    /// `TimecodeInterval` template.
    public static func formTimecodeInterval(
        rational: Fraction,
        at rate: TimecodeFrameRate
    ) throws -> TimecodeInterval {
        try TimecodeInterval(
            rational,
            at: rate,
            base: timecodeSubFramesBase,
            limit: timecodeUpperLimit
        )
    }
}

// MARK: - Time -> Timecode, from resource

extension XMLElement {
    /// FCPXML: Convert raw time attribute value string to `Timecode`.
    func _fcpTimecode(
        fromRational rawString: String,
        tcFormat: FCPXML.TimecodeFormat,
        resourceID: String,
        resources: XMLElement? = nil
    ) throws -> Timecode? {
        guard let fraction = Fraction(fcpxmlString: rawString)
        else { return nil }
        
        return try _fcpTimecode(
            fromRational: fraction,
            tcFormat: tcFormat,
            resourceID: resourceID,
            resources: resources
        )
    }
    
    /// FCPXML: Convert raw time attribute value string to `Timecode`.
    func _fcpTimecode(
        fromRational fraction: Fraction,
        tcFormat: FCPXML.TimecodeFormat,
        resourceID: String,
        resources: XMLElement? = nil
    ) throws -> Timecode? {
        guard let frameRate = _fcpTimecodeFrameRate(
            forResourceID: resourceID,
            tcFormat: tcFormat,
            in: resources
        )
        else { return nil }
        
        return try FCPXML._timecode(
            fromRealTime: fraction.doubleValue,
            frameRate: frameRate
        )
    }
}

// MARK: - Time -> Timecode, with timeline source

extension XMLElement {
    /// FCPXML: Convert time value to `Timecode`.
    /// Traverses the parents of the given XML leaf to determine frame rate.
    func _fcpTimecode(
        fromRational rawString: String,
        frameRateSource: FCPXML.FrameRateSource,
        breadcrumbs: [XMLElement]? = nil,
        resources: XMLElement? = nil
    ) throws -> Timecode? {
        guard let fraction = Fraction(fcpxmlString: rawString)
        else { return nil }
        
        return try _fcpTimecode(
            fromRational: fraction,
            frameRateSource: frameRateSource,
            breadcrumbs: breadcrumbs,
            resources: resources
        )
    }
    
    /// FCPXML: Convert raw time attribute value string to `Timecode`.
    /// Traverses the parents of the given XML leaf to determine frame rate.
    func _fcpTimecode(
        fromRational fraction: Fraction,
        frameRateSource: FCPXML.FrameRateSource,
        breadcrumbs: [XMLElement]? = nil,
        resources: XMLElement? = nil
    ) throws -> Timecode? {
        try _fcpTimecode(
            fromRealTime: fraction.doubleValue,
            frameRateSource: frameRateSource,
            breadcrumbs: breadcrumbs,
            resources: resources
        )
    }
    
    /// FCPXML: Convert raw time in seconds to `Timecode`.
    func _fcpTimecode(
        fromRealTime seconds: TimeInterval,
        frameRateSource: FCPXML.FrameRateSource,
        breadcrumbs: [XMLElement]? = nil,
        resources: XMLElement? = nil
    ) throws -> Timecode? {
        guard let frameRate = _fcpTimecodeFrameRate(
            source: frameRateSource,
            breadcrumbs: breadcrumbs,
            resources: resources
        ) else { return nil }
        
        return try FCPXML.formTimecode(realTime: seconds, at: frameRate)
    }
}

extension FCPXML {
    /// FCPXML: Convert raw time attribute value string to `Timecode`.
    /// Does not auto-scale.
    static func _timecode(
        fromRational rawString: String,
        frameRate: TimecodeFrameRate
    ) throws -> Timecode? {
        guard let fraction = Fraction(fcpxmlString: rawString)
        else { return nil }
        
        return try _timecode(
            fromRational: fraction,
            frameRate: frameRate
        )
    }
    
    /// FCPXML: Convert raw time attribute value string to `Timecode`.
    /// Does not auto-scale.
    static func _timecode(
        fromRational fraction: Fraction,
        frameRate: TimecodeFrameRate
    ) throws -> Timecode? {
        try FCPXML.formTimecode(realTime: fraction.doubleValue, at: frameRate)
    }
    
    /// FCPXML: Convert raw time in seconds to `Timecode`.
    /// Does not auto-scale.
    static func _timecode(
        fromRealTime seconds: TimeInterval,
        frameRate: TimecodeFrameRate
    ) throws -> Timecode? {
        try FCPXML.formTimecode(realTime: seconds, at: frameRate)
    }
}

// MARK: - Time -> TimecodeInterval

extension XMLElement {
    /// FCPXML: Convert raw time attribute value string to `TimecodeInterval`.
    /// Traverses the parents of the given XML leaf to determine frame rate.
    func _fcpTimecodeInterval(
        fromRational rawString: String,
        frameRateSource: FCPXML.FrameRateSource,
        breadcrumbs: [XMLElement]? = nil,
        resources: XMLElement? = nil
    ) throws -> TimecodeInterval? {
        guard let fraction = Fraction(fcpxmlString: rawString)
        else { return nil }
        
        return try _fcpTimecodeInterval(
            fromRational: fraction,
            frameRateSource: frameRateSource,
            breadcrumbs: breadcrumbs,
            resources: resources
        )
    }
    
    /// FCPXML: Convert raw time attribute value string to `TimecodeInterval`.
    /// Traverses the parents of the given XML leaf to determine frame rate.
    func _fcpTimecodeInterval(
        fromRational fraction: Fraction,
        frameRateSource: FCPXML.FrameRateSource,
        breadcrumbs: [XMLElement]? = nil,
        resources: XMLElement? = nil
    ) throws -> TimecodeInterval? {
        try _fcpTimecodeInterval(
            fromRealTime: fraction.doubleValue,
            frameRateSource: frameRateSource,
            breadcrumbs: breadcrumbs,
            resources: resources
        )
    }
    
    /// FCPXML: Convert raw time attribute value string to `TimecodeInterval`.
    /// Traverses the parents of the given XML leaf to determine frame rate.
    func _fcpTimecodeInterval(
        fromRealTime seconds: TimeInterval,
        frameRateSource: FCPXML.FrameRateSource,
        breadcrumbs: [XMLElement]? = nil,
        resources: XMLElement? = nil
    ) throws -> TimecodeInterval? {
        guard let frameRate = _fcpTimecodeFrameRate(
            source: frameRateSource,
            breadcrumbs: breadcrumbs,
            resources: resources
        ) else { return nil }
        
        return try FCPXML._timecodeInterval(
            fromRealTime: seconds,
            frameRate: frameRate
        )
    }
}

extension FCPXML {
    /// Utility:
    /// Convert raw time attribute value string to `TimecodeInterval`.
    static func _timecodeInterval(
        fromRational rawString: String,
        frameRate: TimecodeFrameRate
    ) throws -> TimecodeInterval? {
        guard let fraction = Fraction(fcpxmlString: rawString)
        else { return nil }
        
        return try _timecodeInterval(
            fromRational: fraction,
            frameRate: frameRate
        )
    }
    
    /// Utility:
    /// Convert raw time attribute value string to `TimecodeInterval`.
    static func _timecodeInterval(
        fromRational fraction: Fraction,
        frameRate: TimecodeFrameRate
    ) throws -> TimecodeInterval? {
        try _timecodeInterval(fromRealTime: fraction.doubleValue, frameRate: frameRate)
    }
    
    /// Utility:
    /// Convert raw time attribute value string to `TimecodeInterval`.
    static func _timecodeInterval(
        fromRealTime seconds: TimeInterval,
        frameRate: TimecodeFrameRate
    ) throws -> TimecodeInterval? {
        try FCPXML.formTimecodeInterval(realTime: seconds, at: frameRate)
    }
}

#endif
