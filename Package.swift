// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EnumEx",
    dependencies: [
        .package(url: "https://github.com/jpsim/SourceKitten.git", from: "0.21.0"),
        .package(url: "https://github.com/kylef/Stencil.git", from: "0.11.0"),
        ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "EnumEx",
            dependencies: ["SourceKittenFramework", "Stencil"]),
        ]
)
