//
//  FCPXML Media Multicam.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2022 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation
import SwiftTimecodeCore
import SwiftExtensions

extension FCPXML.Media {
    /// A multi-camera element contains one or more `mc-angle` elements that each manage a series of
    /// other story elements.
    public struct Multicam: FCPXMLElement {
        public let element: XMLElement
        
        public let elementType: FCPXML.ElementType = .multicam
        
        public static let supportedElementTypes: Set<FCPXML.ElementType> = [.multicam]
        
        public init() {
            element = XMLElement(name: elementType.rawValue)
        }
        
        public init?(element: XMLElement) {
            self.element = element
            guard _isElementTypeSupported(element: element) else { return nil }
        }
    }
}

// MARK: - Parameterized init

extension FCPXML.Media.Multicam {
    public init(
        // Media Attributes
        format: String,
        duration: Fraction? = nil,
        tcStart: Fraction? = nil,
        tcFormat: FCPXML.TimecodeFormat? = nil,
        // Element Attributes
        renderFormat: String? = nil,
        angles: (some Sequence<FCPXML.Media.Multicam.Angle>)? = nil,
        metadata: FCPXML.Metadata? = nil
    ) {
        self.init()
        
        // Media Attributes
        self.format = format
        self.duration = duration
        self.tcStart = tcStart
        self.tcFormat = tcFormat
        // Element Attributes
        self.renderFormat = renderFormat
        angles?.forEach { element.addChild($0.element) }
        self.metadata = metadata
    }
}

// MARK: - Structure

extension FCPXML.Media.Multicam {
    public enum Attributes: String {
        case renderFormat
        
        // Media Attributes
        case format
        case duration
        case tcStart
        case tcFormat
    }
    
    // contains DTD mc-angle*
}

// MARK: - Attributes

extension FCPXML.Media.Multicam {
    public var renderFormat: String? {
        get { element.stringValue(forAttributeNamed: Attributes.renderFormat.rawValue) }
        nonmutating set { element.addAttribute(withName: Attributes.renderFormat.rawValue, value: newValue) }
    }
}

extension FCPXML.Media.Multicam: FCPXMLElementMediaAttributes { }

// MARK: - Children

extension FCPXML.Media.Multicam {
    /// Returns child `mc-angle` elements.
    /// Call on a `multicam` element.
    public var angles: LazyFCPXMLChildrenSequence<Angle> {
        element.fcpMCAngles
    }
    
    /// Returns audio and video `mc-angle` elements for the given `mc-source` collection.
    /// Call on a `multicam` element.
    public func audioVideoMCAngles<S: Sequence<FCPXML.MulticamSource>>(
        forMulticamSources sources: S
    ) -> (audioMCAngle: Angle?, videoMCAngle: Angle?) {
        element.fcpAudioVideoMCAngles(forMulticamSources: sources)
    }
    
    /// Returns the child `mc-angle` with the given angle identifier.
    /// Call on a `multicam` element.
    func mcAngle(
        forAngleID angleID: String?
    ) -> Angle? {
        element.fcpMCAngle(forAngleID: angleID)
    }
}

extension FCPXML.Media.Multicam: FCPXMLElementMetadataChild { }

// MARK: - Properties

// Multicam
extension XMLElement {
     /// FCPXML: Returns child `mc-angle` elements.
    /// Call on a `multicam` element.
    public var fcpMCAngles: LazyFCPXMLChildrenSequence<FCPXML.Media.Multicam.Angle> {
        children(whereFCPElement: .mcAngle)
    }
    
    /// FCPXML: Returns audio and video `mc-angle` elements for the given `mc-source` collection.
    /// Call on a `multicam` element.
    public func fcpAudioVideoMCAngles<S: Sequence<XMLElement>>(
        forMulticamSources sources: S
    ) -> (
        audioMCAngle: FCPXML.Media.Multicam.Angle?,
        videoMCAngle: FCPXML.Media.Multicam.Angle?
    ) {
        let (audioAngleID, videoAngleID) = sources.fcpAudioVideoAngleIDs()
        
        let audioMCAngle = fcpMCAngle(forAngleID: audioAngleID)
        let videoMCAngle = fcpMCAngle(forAngleID: videoAngleID)
        
        return (audioMCAngle: audioMCAngle, videoMCAngle: videoMCAngle)
    }
    
    /// FCPXML: Returns audio and video `mc-angle` elements for the given `mc-source` collection.
    /// Call on a `multicam` element.
    public func fcpAudioVideoMCAngles<S: Sequence<FCPXML.MulticamSource>>(
        forMulticamSources sources: S
    ) -> (
        audioMCAngle: FCPXML.Media.Multicam.Angle?,
        videoMCAngle: FCPXML.Media.Multicam.Angle?
    ) {
        fcpAudioVideoMCAngles(
            forMulticamSources: sources.map(\.element)
        )
    }
    
    /// FCPXML: Returns the child `mc-angle` with the given angle identifier.
    /// Call on a `multicam` element.
    public func fcpMCAngle(
        forAngleID angleID: String?
    ) -> FCPXML.Media.Multicam.Angle? {
        guard let angleID = angleID else { return nil }
        return fcpMCAngles
            .first(where: { $0.angleID == angleID })
    }
}

// MARK: - Typing

// Multicam
extension XMLElement {
    /// FCPXML: Returns the element wrapped in a ``FinalCutPro/FCPXML/Media/Multicam`` model object.
    /// Call this on a `multicam` element only.
    public var fcpAsMulticam: FCPXML.Media.Multicam? {
        .init(element: self)
    }
}

#endif
