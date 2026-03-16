//
//  FCPXMLElementModelTypeProtocol Static.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2023 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation

// MARK: - Root

extension FCPXMLElementModelTypeProtocol where
Self == FCPXML.ElementModelType<FCPXML.Root>
{
    public static var fcpxml: FCPXML.ElementModelType<FCPXML.Root> {
        .init()
    }
}

// MARK: - Structure

extension FCPXMLElementModelTypeProtocol where
Self == FCPXML.ElementModelType<FCPXML.Library>
{
    public static var library: FCPXML.ElementModelType<FCPXML.Library> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol where
Self == FCPXML.ElementModelType<FCPXML.Event>
{
    public static var event: FCPXML.ElementModelType<FCPXML.Event> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Project>
{
    public static var project: FCPXML.ElementModelType<FCPXML.Project> {
        .init()
    }
}

// MARK: - Resources

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Asset>
{
    public static var asset: FCPXML.ElementModelType<FCPXML.Asset> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Media>
{
    public static var media: FCPXML.ElementModelType<FCPXML.Media> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Format>
{
    public static var format: FCPXML.ElementModelType<FCPXML.Format> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Effect>
{
    public static var effect: FCPXML.ElementModelType<FCPXML.Effect> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Locator>
{
    public static var locator: FCPXML.ElementModelType<FCPXML.Locator> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.ObjectTracker>
{
    public static var objectTracker: FCPXML.ElementModelType<FCPXML.ObjectTracker> {
        .init()
    }
}

// asset sub-elements

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.MediaRep>
{
    public static var mediaRep: FCPXML.ElementModelType<FCPXML.MediaRep> {
        .init()
    }
}

// media sub-elements

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Media.Multicam>
{
    public static var multicam: FCPXML.ElementModelType<FCPXML.Media.Multicam> {
        .init()
    }
}

// media.multicam sub-elements

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Media.Multicam.Angle>
{
    public static var mcAngle: FCPXML.ElementModelType<FCPXML.Media.Multicam.Angle> {
        .init()
    }
}

// object-tracker sub-elements

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.ObjectTracker.TrackingShape>
{
    public static var trackingShape: FCPXML.ElementModelType<FCPXML.ObjectTracker.TrackingShape> {
        .init()
    }
}

// MARK: - Story Elements

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Sequence>
{
    public static var sequence: FCPXML.ElementModelType<FCPXML.Sequence> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Spine>
{
    public static var spine: FCPXML.ElementModelType<FCPXML.Spine> {
        .init()
    }
}

// MARK: - Clips

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.AssetClip>
{
    public static var assetClip: FCPXML.ElementModelType<FCPXML.AssetClip> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Audio>
{
    public static var audio: FCPXML.ElementModelType<FCPXML.Audio> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Audition>
{
    public static var audition: FCPXML.ElementModelType<FCPXML.Audition> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Clip>
{
    public static var clip: FCPXML.ElementModelType<FCPXML.Clip> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Gap>
{
    public static var gap: FCPXML.ElementModelType<FCPXML.Gap> {
        .init()
    }
}

// TODO: uncomment once `live-drawing` element model is implemented
// extension FCPXMLElementModelTypeProtocol
// where Self == FCPXML.ElementModelType<FCPXML.LiveDrawing>
// {
//     public static var liveDrawing: FCPXML.ElementModelType<FCPXML.LiveDrawing> {
//         .init()
//     }
// }

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.MCClip>
{
    public static var mcClip: FCPXML.ElementModelType<FCPXML.MCClip> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.RefClip>
{
    public static var refClip: FCPXML.ElementModelType<FCPXML.RefClip> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.SyncClip>
{
    public static var syncClip: FCPXML.ElementModelType<FCPXML.SyncClip> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Title>
{
    public static var title: FCPXML.ElementModelType<FCPXML.Title> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Transition>
{
    public static var transition: FCPXML.ElementModelType<FCPXML.Transition> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Video>
{
    public static var video: FCPXML.ElementModelType<FCPXML.Video> {
        .init()
    }
}

// asset-clip sub-elements

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.AudioChannelSource>
{
    public static var audioChannelSource: FCPXML.ElementModelType<FCPXML.AudioChannelSource> {
        .init()
    }
}

// mc-clip sub-elements

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.MulticamSource>
{
    public static var mcSource: FCPXML.ElementModelType<FCPXML.MulticamSource> {
        .init()
    }
}

// sync-clip/ref-clip sub-elements

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.SyncClip.SyncSource>
{
    public static var syncSource: FCPXML.ElementModelType<FCPXML.SyncClip.SyncSource> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.AudioRoleSource>
{
    public static var audioRoleSource: FCPXML.ElementModelType<FCPXML.AudioRoleSource> {
        .init()
    }
}

// MARK: - Annotations

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Caption>
{
    public static var caption: FCPXML.ElementModelType<FCPXML.Caption> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Keyword>
{
    public static var keyword: FCPXML.ElementModelType<FCPXML.Keyword> {
        .init()
    }
}

// Marker model includes `marker` and `chapter-marker` element types
extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Marker>
{
    public static var marker: FCPXML.ElementModelType<FCPXML.Marker> {
        .init()
    }
}

// MARK: - Textual

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Text>
{
    public static var text: FCPXML.ElementModelType<FCPXML.Text> {
        .init()
    }
}

// MARK: - Metadata

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Metadata>
{
    public static var metadata: FCPXML.ElementModelType<FCPXML.Metadata> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.Metadata.Metadatum>
{
    public static var metadatum: FCPXML.ElementModelType<FCPXML.Metadata.Metadatum> {
        .init()
    }
}

// MARK: - Misc

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.ConformRate>
{
    public static var conformRate: FCPXML.ElementModelType<FCPXML.ConformRate> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.TimeMap>
{
    public static var timeMap: FCPXML.ElementModelType<FCPXML.TimeMap> {
        .init()
    }
}

extension FCPXMLElementModelTypeProtocol
where Self == FCPXML.ElementModelType<FCPXML.TimeMap.TimePoint>
{
    public static var timePoint: FCPXML.ElementModelType<FCPXML.TimeMap.TimePoint> {
        .init()
    }
}

#endif
