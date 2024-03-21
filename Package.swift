// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StravaKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "StravaKit", targets: ["StravaKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.8.1"))
    ],
    targets: [
        .target(
            name: "StravaKit",
            dependencies: [
                "Alamofire"
            ]
        ),
        .testTarget(
            name: "StravaKitTests",
            dependencies: ["StravaKit"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
