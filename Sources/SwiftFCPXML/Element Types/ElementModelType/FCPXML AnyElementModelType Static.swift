//
//  FCPXML AnyElementModelType Static.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation

extension FCPXML.AnyElementModelType {
    // MARK: - Root

    public static var fcpxml: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Root>.fcpxml)
    }

    // MARK: - Structure

    public static var library: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Library>.library)
    }

    public static var event: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Event>.event)
    }

    public static var project: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Project>.project)
    }

    // MARK: - Resources

    public static var asset: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Asset>.asset)
    }

    public static var media: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Media>.media)
    }

    public static var format: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Format>.format)
    }

    public static var effect: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Effect>.effect)
    }

    public static var locator: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Locator>.locator)
    }

    public static var objectTracker: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.ObjectTracker>.objectTracker)
    }

    // asset sub-elements

    public static var mediaRep: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.MediaRep>.mediaRep)
    }

    // media sub-elements

    public static var multicam: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Media.Multicam>.multicam)
    }

    // media.multicam sub-elements

    public static var mcAngle: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Media.Multicam.Angle>.mcAngle)
    }

    // object-tracker sub-elements

    public static var trackingShape: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.ObjectTracker.TrackingShape>.trackingShape)
    }

    // MARK: - Story Elements

    public static var sequence: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Sequence>.sequence)
    }

    public static var spine: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Spine>.spine)
    }

    // MARK: - Clips

    public static var assetClip: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.AssetClip>.assetClip)
    }

    public static var audio: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Audio>.audio)
    }

    public static var audition: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Audition>.audition)
    }

    public static var clip: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Clip>.clip)
    }

    public static var gap: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Gap>.gap)
    }

    // TODO: uncomment once `live-drawing` element model is implemented
    // public static var liveDrawing: Self {
    //     .init(base: FCPXML.ElementModelType<FCPXML.LiveDrawing>.liveDrawing)
    // }

    public static var mcClip: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.MCClip>.mcClip)
    }

    public static var refClip: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.RefClip>.refClip)
    }

    public static var syncClip: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.SyncClip>.syncClip)
    }

    public static var title: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Title>.title)
    }

    public static var video: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Video>.video)
    }

    // asset-clip sub-elements

    public static var audioChannelSource: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.AudioChannelSource>.audioChannelSource)
    }

    // mc-clip sub-elements

    public static var mcSource: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.MulticamSource>.mcSource)
    }

    // sync-clip/ref-clip sub-elements

    public static var syncSource: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.SyncClip.SyncSource>.syncSource)
    }

    public static var audioRoleSource: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.AudioRoleSource>.audioRoleSource)
    }

    // MARK: - Annotations

    public static var caption: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Caption>.caption)
    }

    public static var keyword: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Keyword>.keyword)
    }

    // Marker model includes `marker` and `chapter-marker` element types
    public static var marker: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Marker>.marker)
    }

    // MARK: - Textual

    public static var text: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Text>.text)
    }

    // MARK: - Metadata

    public static var metadata: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Metadata>.metadata)
    }

    public static var metadatum: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.Metadata.Metadatum>.metadatum)
    }

    // MARK: - Misc

    public static var conformRate: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.ConformRate>.conformRate)
    }

    public static var timeMap: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.TimeMap>.timeMap)
    }

    public static var timePoint: Self {
        .init(base: FCPXML.ElementModelType<FCPXML.TimeMap.TimePoint>.timePoint)
    }
}

#endif
