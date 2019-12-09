// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Sejima",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(
            name: "Sejima",
            targets: ["Sejima"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Sejima",
            dependencies: [],
            path: "Sejima/Sources"
        ),
    ]
)
