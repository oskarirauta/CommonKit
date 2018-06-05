// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "CommonKit",
    products: [
        .library(name: "CommonKit", targets: ["CommonKit"]),
    ],
    targets: [
        .target(
            name: "CommonKit",
            dependencies: [],
            path: "CommonKit")
    ]
)
