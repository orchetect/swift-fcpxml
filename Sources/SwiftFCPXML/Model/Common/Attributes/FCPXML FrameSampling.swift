//
//  FCPXML FrameSampling.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation

extension FCPXML {
    /// `frameSampling` attribute value.
    /// Used in `conform-rate` and `timeMap` elements.
    public enum FrameSampling: String, Equatable, Hashable, CaseIterable, Sendable {
        case floor
        case nearestNeighbor = "nearest-neighbor"
        case frameBlending = "frame-blending"
        case opticalFlowClassic = "optical-flow-classic"
        case opticalFlow = "optical-flow"
        case opticalFlowFRC = "optical-flow-frc"
    }
}

extension FCPXML.FrameSampling: FCPXMLAttribute {
    public static let attributeName: String = "frameSampling"
}

#endif
