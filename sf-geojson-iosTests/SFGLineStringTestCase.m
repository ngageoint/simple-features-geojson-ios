//
//  SFGLineStringTestCase.m
//  sf-geojson-iosTests
//
//  Created by Brian Osborn on 8/1/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGLineStringTestCase.h"
#import "SFGTestUtils.h"
#import "SFGFeatureConverter.h"

@implementation SFGLineStringTestCase

-(void) testSerializeLineString{
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    [points addObject:[SFPoint pointWithXValue:100 andYValue:10]];
    [points addObject:[SFPoint pointWithXValue:101 andYValue:1]];
    SFLineString *lineString = [SFLineString lineStringWithPoints:points];
    [SFGTestUtils compareSFGeometry:lineString withInput:@"{\"type\":\"LineString\",\"coordinates\":[[100,10],[101,1]]}"];
}

-(void) testSerializeLineStringWithAltitude{
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    [points addObject:[SFPoint pointWithXValue:100 andYValue:10 andZValue:15]];
    [points addObject:[SFPoint pointWithXValue:101 andYValue:1 andZValue:11]];
    SFLineString *lineString = [SFLineString lineStringWithPoints:points];
    [SFGTestUtils compareSFGeometry:lineString withInput:@"{\"type\":\"LineString\",\"coordinates\":[[100,10,15],[101,1,11]]}"];
}

-(void) testDeserializeLineString{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:@"{\"type\":\"LineString\",\"coordinates\":[[100.0, 0.0],[101.0, 1.0]]}"];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGLineString class]];
    SFGLineString *lineString = (SFGLineString *) object;
    NSArray *coordinates = [lineString coordinates];
    [SFGTestUtils assertPositionWithLongitude:100.0 andLatitude:0.0 andAltitude:nil andAdditional:nil andCoordinates:[coordinates objectAtIndex:0]];
    [SFGTestUtils assertPositionWithLongitude:101.0 andLatitude:1.0 andAltitude:nil andAdditional:nil andCoordinates:[coordinates objectAtIndex:1]];
}

-(void) testDeserializeLineStringWithAltitude{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:@"{\"type\":\"LineString\",\"coordinates\":[[100.0, 10.0, -20.0],[101.0, 1.0, -10.0]]}"];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGLineString class]];
    SFGLineString *lineString = (SFGLineString *) object;
    NSArray *coordinates = [lineString coordinates];
    [SFGTestUtils assertPositionWithLongitude:100.0 andLatitude:10.0 andAltitude:[NSNumber numberWithDouble:-20.0] andAdditional:nil andCoordinates:[coordinates objectAtIndex:0]];
    [SFGTestUtils assertPositionWithLongitude:101.0 andLatitude:1.0 andAltitude:[NSNumber numberWithDouble:-10.0] andAdditional:nil andCoordinates:[coordinates objectAtIndex:1]];
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
    
    NSMutableArray<SFPoint *> *points = [NSMutableArray array];
    [points addObject:[SFPoint pointWithXValue:100.0 andYValue:10.0]];
    [points addObject:[SFPoint pointWithXValue:101.0 andYValue:1.0]];
    SFLineString *lineString = [SFLineString lineStringWithPoints:points];
    
    return lineString;
}

@end
