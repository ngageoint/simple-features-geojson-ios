# Simple Features GeoJSON iOS

#### Simple Features GeoJSON Lib ####

The Simple Features Libraries were developed at the [National Geospatial-Intelligence Agency (NGA)](http://www.nga.mil/) in collaboration with [BIT Systems](https://www.caci.com/bit-systems/). The government has "unlimited rights" and is releasing this software to increase the impact of government investments by providing developers with the opportunity to take things in new directions. The software use, modification, and distribution rights are stipulated within the [MIT license](http://choosealicense.com/licenses/mit/).

### Pull Requests ###
If you'd like to contribute to this project, please make a pull request. We'll review the pull request and discuss the changes. All pull request contributions to this project will be released under the MIT license.

Software source code previously released under an open source license and then modified by NGA staff is considered a "joint work" (see 17 USC § 101); it is partially copyrighted, partially public domain, and as a whole is protected by the copyrights of the non-government authors and must be released according to the terms of the original open source license.

### About ###

[Simple Features GeoJSON](http://ngageoint.github.io/simple-features-geojson-ios/) is an iOS Objective-C library for writing and reading [Simple Feature](https://github.com/ngageoint/simple-features-ios) Geometries to and from GeoJSON.

### Usage ###

View the latest [Appledoc](http://ngageoint.github.io/simple-features-geojson-ios/docs/api/)

#### Read ####

```objectivec

@import SimpleFeaturesGeoJSON;

// NSString *content = ...

SFGGeometry *geometry = [SFGFeatureConverter jsonToGeometry:content];
SFGeometry *simpleGeometry = [geometry geometry];

/* Read as a generic GeoJSON object, Feature, or Feature Collection */
// SFGGeoJSONObject *geoJSONObject = [SFGFeatureConverter jsonToObject:content];
// SFGFeature *feature = [SFGFeatureConverter jsonToFeature:content];
// SFGFeatureCollection *featureCollection = [SFGFeatureConverter jsonToFeatureCollection:content];

```

#### Write ####

```objectivec

@import SimpleFeaturesGeoJSON;

// SFGeometry *geometry = ...

NSString *content = [SFGFeatureConverter simpleGeometryToJSON:geometry];

SFGFeature *feature = [SFGFeatureConverter simpleGeometryToFeature:geometry];
NSString *featureContent = [SFGFeatureConverter objectToJSON:feature];

SFGFeatureCollection *featureCollection = [SFGFeatureConverter simpleGeometryToFeatureCollection:geometry];
NSString *featureCollectionContent = [SFGFeatureConverter objectToJSON:featureCollection];

NSDictionary *contentTree = [SFGFeatureConverter simpleGeometryToTree:geometry];

```

### Build ###

[![Build](https://github.com/ngageoint/simple-features-geojson-ios/actions/workflows/build.yml/badge.svg)](https://github.com/ngageoint/simple-features-geojson-ios/actions/workflows/build.yml)

Build this repository using SPM:

    swift build

Open the Swift Package in Xcode:

    open Package.swift

Run tests from Xcode or from command line:

    swift test

### Include Library ###

Add a package dependency version:

    .package(url: "https://github.com/ngageoint/simple-features-geojson-ios", from: "5.0.0"),

    # Or specific branch:

    .package(url: "https://github.com/ngageoint/simple-features-geojson-ios", branch: "release/5.0.0"),
    
    # Or as a local dependency:        

    .package(name: "simple-features-geojson-ios", path: "../simple-features-geojson-ios"),

Use it in a target:

        .target(
            name: "MyLibrary",
            dependencies: [
                .product(name: "SimpleFeaturesGeoJSON", package: "simple-features-geojson-ios")
            ]
        )

### Swift ###

To use from Swift, import the framework:

    import SimpleFeaturesGeoJSON

#### Read ####

```swift

// var content: String = ...

let geometry: SFGGeometry = SFGFeatureConverter.json(toGeometry: content)
let simpleGeometry: SFGeometry = geometry.geometry()

/* Read as a generic GeoJSON object, Feature, or Feature Collection */
// let geoJSONObject : SFGGeoJSONObject = SFGFeatureConverter.json(toObject: content)
// let feature: SFGFeature = SFGFeatureConverter.json(toFeature: content)
// let featureCollection : SFGFeatureCollection = SFGFeatureConverter.json(toFeatureCollection: content)

```

#### Write ####

```swift

// let geometry : SFGeometry = ...

let content : String = SFGFeatureConverter.simpleGeometry(toJSON: geometry)

let feature : SFGFeature = SFGFeatureConverter.simpleGeometry(toFeature: geometry)
let featureContent : String = SFGFeatureConverter.object(toJSON: feature)

let featureCollection : SFGFeatureCollection = SFGFeatureConverter.simpleGeometry(toFeatureCollection: geometry)
let featureCollectionContent : String = SFGFeatureConverter.object(toJSON: featureCollection)

let contentTree : Dictionary = SFGFeatureConverter.simpleGeometry(toTree: geometry)

```

### Remote Dependencies ###

* [Simple Features](https://github.com/ngageoint/simple-features-ios) (The MIT License (MIT)) - Simple Features Lib
