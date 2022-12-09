// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "sf-geojson-ios",
    platforms: [.macOS(.v10_10), .iOS(.v12), .tvOS(.v9)],
    products: [
        .library(
            name: "sf-geojson-ios",
            targets: ["sf-geojson-ios"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ngageoint/simple-features-ios", .branch("package")),
        //.package(name: "sf-ios", path: "../simple-features-ios"),
    ],
    targets: [
        .target(
            name: "sf-geojson-ios",
            dependencies: [
                //"sf-ios"
                .product(name: "sf-ios", package: "simple-features-ios")
              ],
            path: "sf-geojson-ios",
            exclude: ["Info.plist", "sf-geojson-ios-Bridging-Header.h", "sf-geojson-ios-Prefix.pch"],
            publicHeadersPath: ""
            ),
        .testTarget(
            name: "sf-geojson-iosTests",
            dependencies: ["sf-geojson-ios"],
            path: "sf-geojson-iosTests",
            exclude: ["Info.plist", "sf-geojson-iosTests-Bridging-Header.h", "SFGSwiftReadmeTest.swift"]
            ),
    ]
)
