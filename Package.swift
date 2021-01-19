// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Sejima",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "Sejima",
            targets: ["Sejima"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/MoveUpwards/Neumann.git", from: "2.0.1")
    ],
    targets: [
        .target(
            name: "Sejima",
            dependencies: ["Neumann"],
            path: "Sejima/Sources"
        ),
    ]
)
