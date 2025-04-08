//
//  SFGGeometryCollectionTestCase.m
//  sf-geojson-iosTests
//
//  Created by Brian Osborn on 8/1/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometryCollectionTestCase.h"
#import "SFGTestUtils.h"
@import SimpleFeaturesGeoJSON;

@implementation SFGGeometryCollectionTestCase

static NSString *GEOMETRYCOLLECTION = @"{\"type\":\"GeometryCollection\",\"geometries\":[{\"type\":\"Point\",\"coordinates\":[61.5,48]},{\"type\":\"LineString\",\"coordinates\":[[100,10],[101,1]]}]}";
static NSString *GEOMETRYCOLLECTION_WITH_ALT = @"{\"type\":\"GeometryCollection\",\"geometries\":[{\"type\":\"Point\",\"coordinates\":[61.34765625,48.63290858589535,12]},{\"type\":\"LineString\",\"coordinates\":[[100,10,5],[101,1,10]]}]}";

-(void) testSerializeGeometryCollection{
    SFGeometry *geometryCollection = [self createTestGeometry];
    [SFGTestUtils compareSFGeometry:geometryCollection withInput:GEOMETRYCOLLECTION];
}

-(void) testSerializeGeometryCollectionWithAltitude{
    SFGeometryCollection *geometryCollection = [SFGeometryCollection geometryCollectionWithHasZ:YES andHasM:NO];
    SFPoint *point = [SFPoint pointWithXValue:61.34765625 andYValue:48.63290858589535 andZValue:12];
    [geometryCollection addGeometry:point];
    SFLineString *lineString = [SFLineString lineStringWithHasZ:YES andHasM:NO];
    [lineString addPoint:[SFPoint pointWithXValue:100.0 andYValue:10.0 andZValue:5.0]];
    [lineString addPoint:[SFPoint pointWithXValue:101.0 andYValue:1.0 andZValue:10.0]];
    [geometryCollection addGeometry:lineString];
    [SFGTestUtils compareSFGeometry:geometryCollection withInput:GEOMETRYCOLLECTION_WITH_ALT];
}

-(void) testDeserializeGeometryCollection{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:GEOMETRYCOLLECTION];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGGeometryCollection class]];
    SFGGeometryCollection *gjGeometryCollection = (SFGGeometryCollection *) object;
    SFGeometry *geometry = [gjGeometryCollection geometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFGeometryCollection class]];
    SFGeometryCollection *geometryCollection = (SFGeometryCollection *) geometry;
    NSArray<SFGeometry *> *geometries = [geometryCollection geometries];
    [SFGTestUtils assertTrue:geometries.count == 2];
    SFGeometry *geometry1 = [geometries objectAtIndex:0];
    [SFGTestUtils assertTrue:[geometry1 class] == [SFPoint class]];
    SFPoint *point = (SFPoint *) geometry1;
    [SFGTestUtils assertEqualWithValue:[SFPoint pointWithXValue:61.5 andYValue:48] andValue2:point];
    SFGeometry *geometry2 = [geometries objectAtIndex:1];
    [SFGTestUtils assertTrue:[geometry2 class] == [SFLineString class]];
    SFLineString *lineString = (SFLineString *) geometry2;
    [SFGTestUtils assertEqualWithValue:[SFPoint pointWithXValue:100.0 andYValue:10.0] andValue2:[lineString pointAtIndex:0]];
    [SFGTestUtils assertEqualWithValue:[SFPoint pointWithXValue:101.0 andYValue:1.0] andValue2:[lineString pointAtIndex:1]];
}

-(void) testDeserializeGeometryCollectionWithAltitude{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:GEOMETRYCOLLECTION_WITH_ALT];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGGeometryCollection class]];
    SFGGeometryCollection *gjGeometryCollection = (SFGGeometryCollection *) object;
    SFGeometry *geometry = [gjGeometryCollection geometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFGeometryCollection class]];
    SFGeometryCollection *geometryCollection = (SFGeometryCollection *) geometry;
    NSArray<SFGeometry *> *geometries = [geometryCollection geometries];
    [SFGTestUtils assertTrue:geometries.count == 2];
    SFGeometry *geometry1 = [geometries objectAtIndex:0];
    [SFGTestUtils assertTrue:[geometry1 class] == [SFPoint class]];
    SFPoint *point = (SFPoint *) geometry1;
    [SFGTestUtils assertEqualWithValue:[SFPoint pointWithXValue:61.34765625 andYValue:48.63290858589535 andZValue:12] andValue2:point];
    SFGeometry *geometry2 = [geometries objectAtIndex:1];
    [SFGTestUtils assertTrue:[geometry2 class] == [SFLineString class]];
    SFLineString *lineString = (SFLineString *) geometry2;
    [SFGTestUtils assertEqualWithValue:[SFPoint pointWithXValue:100.0 andYValue:10.0 andZValue:5.0] andValue2:[lineString pointAtIndex:0]];
    [SFGTestUtils assertEqualWithValue:[SFPoint pointWithXValue:101.0 andYValue:1.0 andZValue:10.0] andValue2:[lineString pointAtIndex:1]];
}

-(void) testGeometry{
    [SFGTestUtils simpleGeometryToGeometry:[self createTestGeometry]];
}

-(void) testTree{
    [SFGTestUtils simpleGeometryToTree:[self createTestGeometry]];
}

-(void) testJSON{
    [SFGTestUtils simpleGeometryToJSON:[self createTestGeometry]];
}

-(SFGeometry *) createTestGeometry{
    
    SFGeometryCollection *geometryCollection = [SFGeometryCollection geometryCollection];
    SFPoint *point = [SFPoint pointWithXValue:61.5 andYValue:48];
    [geometryCollection addGeometry:point];
    SFLineString *lineString = [SFLineString lineString];
    [lineString addPoint:[SFPoint pointWithXValue:100.0 andYValue:10.0]];
    [lineString addPoint:[SFPoint pointWithXValue:101.0 andYValue:1.0]];
    [geometryCollection addGeometry:lineString];
    
    return geometryCollection;
}

@end
