// swift-tools-version: 6.2
// (be sure to update the .swift-version file when this Swift version changes)

import PackageDescription

let package = Package(
    name: "swift-fcpxml",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(name: "SwiftFCPXML", targets: ["SwiftFCPXML"])
    ],
    dependencies: [
        .package(url: "https://github.com/orchetect/swift-extensions", from: "2.1.1"),
        .package(url: "https://github.com/orchetect/swift-timecode", from: "3.1.0"),
        
        // testing-only dependencies
        .package(url: "https://github.com/orchetect/swift-testing-extensions", from: "0.3.0"),
    ],
    targets: [
        .target(
            name: "SwiftFCPXML",
            dependencies: [
                .product(name: "SwiftExtensions", package: "swift-extensions"),
                .product(name: "SwiftTimecodeCore", package: "swift-timecode")
            ]
        ),
        .testTarget(
            name: "SwiftFCPXMLTests",
            dependencies: [
                "SwiftFCPXML",
                .product(name: "TestingExtensions", package: "swift-testing-extensions")
            ],
            resources: [
                .copy("TestResource/FCPXML Exports")
            ]
        )
    ]
)
