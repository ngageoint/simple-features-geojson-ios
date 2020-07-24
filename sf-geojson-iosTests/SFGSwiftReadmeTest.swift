//
//  SFGSwiftReadmeTest.swift
//  sf-geojson-iosTests
//
//  Created by Brian Osborn on 7/24/20.
//  Copyright © 2020 NGA. All rights reserved.
//

import XCTest

/**
* README example tests
*/
class SFGSwiftReadmeTest: XCTestCase{
    
    static var TEST_GEOMETRY : SFGeometry = SFPoint(xValue: 1.0, andYValue: 1.0)
    static var TEST_CONTENT: String = "{\"type\":\"Point\",\"coordinates\":[1,1]}"
    
    /**
     * Test read
     */
    func testRead(){
        
        let geometry: SFGeometry = readTester(SFGSwiftReadmeTest.TEST_CONTENT)
        
        SFGTestUtils.assertEqual(withValue: SFGSwiftReadmeTest.TEST_GEOMETRY, andValue2: geometry)
        
    }
    
    /**
     * Test read
     *
     * @param content
     *            content
     * @return geometry
     */
    func readTester(_ content: String) -> SFGeometry{
        return SFGSwiftReadmeTest.TEST_GEOMETRY // TODO
    }
    
    /**
     * Test write
     */
    func testWrite(){
        
        let content: String = writeTester(SFGSwiftReadmeTest.TEST_GEOMETRY)
        
        SFGTestUtils.assertEqual(withValue: SFGSwiftReadmeTest.TEST_CONTENT as NSObject, andValue2: content as NSObject)
        
    }
    
    /**
     * Test write
     *
     * @param geometry
     *            geometry
     * @return content
     */
    func writeTester(_ geometry: SFGeometry) -> String{
        return SFGSwiftReadmeTest.TEST_CONTENT //TODO
    }
    
}
