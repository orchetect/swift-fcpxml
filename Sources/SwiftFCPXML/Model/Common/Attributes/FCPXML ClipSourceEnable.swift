//
//  FCPXML ClipSourceEnable.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2022 Steffan Andrews • Licensed under MIT License
//

#if os(macOS) // XMLNode only works on macOS

import Foundation

extension FCPXML {
    /// Clip source enable value. (Used with `asset-clip` and `mc-clip`)
    public enum ClipSourceEnable: String, Equatable, Hashable, CaseIterable, Sendable {
        /// Audio and Video.
        case all
        
        /// Audio source.
        case audio
        
        /// Video source.
        case video
    }
}

extension FCPXML.ClipSourceEnable: FCPXMLAttribute {
    public static let attributeName: String = "srcEnable"
}

extension XMLElement {
    /// FCPXML: Returns value for attribute `srcEnable`. (Default: `.all`)
    /// Call on a `asset-clip` or `mc-clip` element only.
    public var fcpClipSourceEnable: FCPXML.ClipSourceEnable {
        get {
            let defaultValue: FCPXML.ClipSourceEnable = .all
            
            guard let value = stringValue(forAttributeNamed: FCPXML.ClipSourceEnable.attributeName)
            else { return defaultValue }
            
            return FCPXML.ClipSourceEnable(rawValue: value) ?? defaultValue
        }
        set {
            addAttribute(withName: FCPXML.ClipSourceEnable.attributeName,
                         value: newValue.rawValue)
        }
    }
}

#endif
