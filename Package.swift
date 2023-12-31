// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PasswordStrengthIndicator",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .watchOS(.v7),
        .tvOS(.v14)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "PasswordStrengthIndicator",
            targets: ["PasswordStrengthIndicator"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        .target(
            name: "PasswordStrengthIndicator",
            dependencies: []
        ),
        .testTarget(
            name: "PasswordStrengthIndicatorTests",
            dependencies: ["PasswordStrengthIndicator"]
        ),
    ]
)

