//
//  SFGReadmeTest.m
//  sf-geojson-iosTests
//
//  Created by Brian Osborn on 7/24/20.
//  Copyright © 2020 NGA. All rights reserved.
//

#import "SFGReadmeTest.h"
#import "SFGTestUtils.h"
#import "SFGeometry.h"
#import "SFPoint.h"
#import "SFGFeatureConverter.h"

@implementation SFGReadmeTest

static SFGeometry *TEST_GEOMETRY;
static NSString *TEST_CONTENT;

-(void) setUp{
    TEST_GEOMETRY = [[SFPoint alloc] initWithXValue:1.0 andYValue:1.0];
    TEST_CONTENT = @"{\"type\":\"Point\",\"coordinates\":[1,1]}";
}

/**
 * Test read
 */
-(void) testRead{
    
    SFGGeometry *geometry = [self readTester:TEST_CONTENT];
    
    [SFGTestUtils assertEqualWithValue:TEST_GEOMETRY andValue2:[geometry geometry]];
    
}

/**
 * Test read
 *
 * @param content
 *            content
 * @return geometry
 */
-(SFGGeometry *) readTester: (NSString *) content{
    
    // NSString *content = ...

    SFGGeometry *geometry = [SFGFeatureConverter jsonToGeometry:content];
    SFGeometry *simpleGeometry = [geometry geometry];

    /* Read as a generic GeoJSON object, Feature, or Feature Collection */
    // SFGGeoJSONObject *geoJSONObject = [SFGFeatureConverter jsonToObject:content];
    // SFGFeature *feature = [SFGFeatureConverter jsonToFeature:content];
    // SFGFeatureCollection *featureCollection = [SFGFeatureConverter jsonToFeatureCollection:content];
    
    return geometry;
}

/**
 * Test write
 */
-(void) testWrite{
    
    NSString *content = [self writeTester:TEST_GEOMETRY];

    [SFGTestUtils assertEqualWithValue:TEST_CONTENT andValue2:content];
    
}

/**
 * Test write
 *
 * @param geometry
 *            geometry
 * @return content
 */
-(NSString *) writeTester: (SFGeometry *) geometry{
    
    // SFGeometry *geometry = ...
    
    NSString *content = [SFGFeatureConverter simpleGeometryToJSON:geometry];
    
    SFGFeature *feature = [SFGFeatureConverter simpleGeometryToFeature:geometry];
    NSString *featureContent = [SFGFeatureConverter objectToJSON:feature];
    
    SFGFeatureCollection *featureCollection = [SFGFeatureConverter simpleGeometryToFeatureCollection:geometry];
    NSString *featureCollectionContent = [SFGFeatureConverter objectToJSON:featureCollection];
    
    NSDictionary *contentTree = [SFGFeatureConverter simpleGeometryToTree:geometry];
    
    return content;
}

@end
