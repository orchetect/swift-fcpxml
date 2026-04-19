//
//  API-swift-daw-file-tools-0.7.2.swift
//  swift-fcpxml • https://github.com/orchetect/swift-fcpxml
//  © 2026 Steffan Andrews • Licensed under MIT License
//

// MARK: - API Deprecations - swift-daw-file-tools 0.7.2

#if os(macOS) // XMLNode only works on macOS

extension FCPXML.Version {
    @available(*, deprecated, renamed: "init(_:_:)")
    public init(major: Int, minor: Int) {
        self.init(UInt(major), UInt(minor))
    }
}

#endif
