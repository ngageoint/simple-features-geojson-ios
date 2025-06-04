//
//  SFGSwiftReadmeTest.swift
//  sf-geojson-iosTests
//
//  Created by Brian Osborn on 7/24/20.
//  Copyright © 2020 NGA. All rights reserved.
//

import XCTest
import SimpleFeatures
import SimpleFeaturesGeoJSON
import SimpleFeatureGeoJSONTestHelpers

/**
* README.md example tests for sample code
*/
class SFGSwiftReadmeTest: XCTestCase{
    
    static var TEST_GEOMETRY : SFGeometry = SFPoint(xValue: 1.0, andYValue: 1.0)
    static var TEST_CONTENT: String = "{\"type\":\"Point\",\"coordinates\":[1,1]}"
    
    /**
     * Test read for README.md
     */
    func testRead(){
        
        let geometry: SFGGeometry = readTester(SFGSwiftReadmeTest.TEST_CONTENT)
        
        SFGTestUtils.assertEqual(withValue: SFGSwiftReadmeTest.TEST_GEOMETRY, andValue2: geometry.geometry())
        
    }
    
    /**
     * Test read for README.md
     *
     * @param content
     *            content
     * @return geometry
     */
    func readTester(_ content: String) -> SFGGeometry{
        
        // var content: String = ...

        let geometry: SFGGeometry = SFGFeatureConverter.json(toGeometry: content)
        let simpleGeometry: SFGeometry = geometry.geometry()

        /* Read as a generic GeoJSON object, Feature, or Feature Collection */
        // let geoJSONObject : SFGGeoJSONObject = SFGFeatureConverter.json(toObject: content)
        // let feature: SFGFeature = SFGFeatureConverter.json(toFeature: content)
        // let featureCollection : SFGFeatureCollection = SFGFeatureConverter.json(toFeatureCollection: content)
        
        // Suppress warnings
        print(simpleGeometry)
        
        return geometry;
    }
    
    /**
     * Test write for README.md
     */
    func testWrite(){
        
        let content: String = writeTester(SFGSwiftReadmeTest.TEST_GEOMETRY)
        
        SFGTestUtils.assertEqual(withValue: SFGSwiftReadmeTest.TEST_CONTENT as NSObject, andValue2: content as NSObject)
        
    }
    
    /**
     * Test write for README.md
     *
     * @param geometry
     *            geometry
     * @return content
     */
    func writeTester(_ geometry: SFGeometry) -> String{
        
        // let geometry : SFGeometry = ...
        
        let content : String = SFGFeatureConverter.simpleGeometry(toJSON: geometry)
        
        let feature : SFGFeature = SFGFeatureConverter.simpleGeometry(toFeature: geometry)
        let featureContent : String = SFGFeatureConverter.object(toJSON: feature)
        
        let featureCollection : SFGFeatureCollection = SFGFeatureConverter.simpleGeometry(toFeatureCollection: geometry)
        let featureCollectionContent : String = SFGFeatureConverter.object(toJSON: featureCollection)
        
        let contentTree : Dictionary = SFGFeatureConverter.simpleGeometry(toTree: geometry)
        
        // Suppress warnings
        print(featureContent)
        print(featureCollectionContent)
        print(contentTree)
        
        return content;
    }
    
}
