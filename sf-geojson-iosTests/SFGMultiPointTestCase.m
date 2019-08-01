//
//  SFGMultiPointTestCase.m
//  sf-geojson-iosTests
//
//  Created by Brian Osborn on 8/1/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGMultiPointTestCase.h"
#import "SFGTestUtils.h"
#import "SFGMultiPoint.h"
#import "SFGFeatureConverter.h"

@implementation SFGMultiPointTestCase

static NSString *MULTIPOINT = @"{\"type\":\"MultiPoint\",\"coordinates\":[[100,10],[101,1]]}";
static NSString *MULTIPOINT_WITH_ALT = @"{\"type\":\"MultiPoint\",\"coordinates\":[[100,10,-20],[101,1,-10]]}";

-(void) testSerializeSFMultiPoint{
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:100 andYValue:10]];
    [points addObject:[[SFPoint alloc] initWithXValue:101 andYValue:1]];
    SFMultiPoint *multiPoint = [[SFMultiPoint alloc] initWithPoints:points];
    [SFGTestUtils compareSFGeometry:multiPoint withInput:MULTIPOINT];
}

-(void) testSerializeSFMultiPointWithAltitude{
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:100 andYValue:10 andZValue:-20]];
    [points addObject:[[SFPoint alloc] initWithXValue:101 andYValue:1 andZValue:-10]];
    SFMultiPoint *multiPoint = [[SFMultiPoint alloc] initWithPoints:points];
    [SFGTestUtils compareSFGeometry:multiPoint withInput:MULTIPOINT_WITH_ALT];
}

-(void) testDeserializeMultiPoint{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:MULTIPOINT];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGMultiPoint class]];
    SFGMultiPoint *multiPoint = (SFGMultiPoint *) object;
    NSArray *coordinates = [multiPoint coordinates];
    [SFGTestUtils assertPositionWithLongitude:100.0 andLatitude:10.0 andAltitude:nil andAdditional:nil andCoordinates:[coordinates objectAtIndex:0]];
    [SFGTestUtils assertPositionWithLongitude:101.0 andLatitude:1.0 andAltitude:nil andAdditional:nil andCoordinates:[coordinates objectAtIndex:1]];
}

-(void) testDeserializeMultiPointWithAltitude{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:MULTIPOINT_WITH_ALT];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGMultiPoint class]];
    SFGMultiPoint *multiPoint = (SFGMultiPoint *) object;
    NSArray *coordinates = [multiPoint coordinates];
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
    
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:100.0 andYValue:10.0]];
    [points addObject:[[SFPoint alloc] initWithXValue:101.0 andYValue:1.0]];
    SFMultiPoint *multiPoint = [[SFMultiPoint alloc] initWithPoints:points];
    
    return multiPoint;
}

@end
