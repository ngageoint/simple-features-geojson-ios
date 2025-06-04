// swift-tools-version:5.10
import PackageDescription

/// SPM Conversion Notes
/// * Hyphens break the resource bundling logic in Objective-C, so we're using full names
/// * sf-geoson is now SimpleFeaturesGeoJSON

let package = Package(
    name: "SimpleFeaturesGeoJSON",
    platforms: [.macOS(.v11), .iOS(.v13)],
    products: [
        .library(
            name: "SimpleFeaturesGeoJSON",
            targets: ["SimpleFeaturesGeoJSON"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ngageoint/simple-features-ios", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "SimpleFeaturesGeoJSON",
            dependencies: [
                .product(name: "SimpleFeatures", package: "simple-features-ios")
            ],
            path: "sf-geojson-ios",
            publicHeadersPath: "include"
        ),
        .testTarget(
            name: "SimpleFeaturesGeoJSONTests", // Use full name without hyphens to prevent SPM test resource bug
            dependencies: [
                "SimpleFeaturesGeoJSON",
                "SimpleFeatureGeoJSONTestHelpers"
            ],
            path: "sf-geojson-iosTests",
            resources: [    // In Objective-C, the tests fail to load resource using SWIFTPM_MODULE_BUNDLE macro with hyphens for target/testTarget names, so we'll use full names.
                .copy("fc-points.geojson"),
                .copy("fc-points-altitude.geojson"),
                .copy("gc.geojson"),
                .copy("gc-multiple.geojson")
            ]
        ),
        .testTarget(
            name: "SimpleFeaturesGeoJSONTestsSwift",
            dependencies: [
                "SimpleFeaturesGeoJSON",
                "SimpleFeatureGeoJSONTestHelpers",
            ],
            path: "sf-geojson-iosTests-swift"
        ),
        .target(
            name: "SimpleFeatureGeoJSONTestHelpers", // Shared helper code
            dependencies: [
                "SimpleFeaturesGeoJSON",
            ],
            path: "sf-geojson-ios-TestUtils",
            publicHeadersPath: ""
        ),
    ]
)
