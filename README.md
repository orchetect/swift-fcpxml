# swift-fcpxml

[![Platforms - macOS 10.15+ | iOS 10+ | tvOS 10+ | visionOS 1+](https://img.shields.io/badge/platforms-macOS%2010.15+%20|%20iOS%2010+%20|%20tvOS%2010+%20|%20visionOS%201+-lightgrey.svg?style=flat)](https://developer.apple.com/swift) ![Swift 5.5-6.0](https://img.shields.io/badge/Swift-5.5–6.0-orange.svg?style=flat) [![Xcode 13-16](https://img.shields.io/badge/Xcode-13–16-blue.svg?style=flat)](https://developer.apple.com/swift) [![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/orchetect/swift-fcpxml/blob/main/LICENSE)

A Swift library for efficient parsing and extracting timeline events on FCPXML (Final Cut Pro XML) files.

> [!NOTE]
>
> The evolution of this library is ongoing, and features are added on an as-needed basis.
>
> Currently a substantial amount of the FCPXML DTD is modeled and traversable, but is not entirely complete - some of the more esoteric XML elements have not yet beed modeled.
>
> The core feature-set does allow for comprehensive reasoning on the XML in order to extract timeline events such as markers, and is being used actively in production.

## Installation

### Swift Package Manager (SPM)

To add this package to an Xcode app project, use:

 `https://github.com/orchetect/swift-fcpxml` as the URL.

To add this package to a Swift package, add it to your package dependencies:

```swift
.package(url: "https://github.com/orchetect/swift-fcpxml", from: "0.1.0")
```

Then add it to your target dependencies:

```swift
.product(name: "SwiftFCPXML", package: "swift-fcpxml")
```

## Dependencies

- [swift-timecode](https://github.com/orchetect/swift-timecode) to represent timecode values and frame rates

## Documentation

No formal documentation yet.

## Unit Tests

Core unit tests implemented. More exhaustive tests can be added in future.

## Affiliation

The author(s) have no affiliation with Apple or Final Cut Pro. This library is built based on open file data format has been made publicly available by Apple. No reverse-engineering of software was involved in implementation of this library. The goal is to promote easier interoperability for developers.

The library is provided as-is with no warranties. See the [LICENSE](https://github.com/orchetect/swift-fcpxml/blob/master/LICENSE) for more details.

## Author

Coded by a bunch of 🐹 hamsters in a trenchcoat that calls itself [@orchetect](https://github.com/orchetect).

## License

Licensed under the MIT license. See [LICENSE](https://github.com/orchetect/swift-fcpxml/blob/master/LICENSE) for details.

## Community & Support

Please do not email maintainers for technical support. Several options are available for issues and questions:

- Questions and feature ideas can be posted to [Discussions](https://github.com/orchetect/swift-fcpxml/discussions).
- If an issue is a verifiable bug with reproducible steps it may be posted in [Issues](https://github.com/orchetect/swift-fcpxml/issues).

## Contributions

Contributions are welcome. Posting in [Discussions](https://github.com/orchetect/swift-fcpxml/discussions) first prior to new submitting PRs for features or modifications is encouraged.

## Legacy

This repository was formerly a part of [swift-daw-file-tools](https://github.com/orchetect/swift-daw-file-tools) (previously known as DAWFileKit), and was extracted into its own repository in March 2026.
