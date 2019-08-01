//
//  SFGMultiLineStringTestCase.m
//  sf-geojson-iosTests
//
//  Created by Brian Osborn on 8/1/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGMultiLineStringTestCase.h"
#import "SFGTestUtils.h"
#import "SFGMultiLineString.h"
#import "SFGFeatureConverter.h"

static NSString *MULTILINESTRING = @"{\"type\":\"MultiLineString\",\"coordinates\":[[[100,10],[101,1],[101,10]]]}";
static NSString *MULTILINESTRING_WITH_ALT = @"{\"type\":\"MultiLineString\",\"coordinates\":[[[100,10,5],[101,1,10],[101,10,15]]]}";
static NSString *MULTILINESTRING_WITH_MULTIPLE = @"{\"type\":\"MultiLineString\",\"coordinates\":[[[-100,-50],[100,-50],[1,50]],[[-50,-25],[50,-25],[-1,25]]]}";

@implementation SFGMultiLineStringTestCase

-(void) testSerializeSFMultiLineString{
    NSMutableArray<SFLineString *> *lineStrings = [[NSMutableArray alloc] init];
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:100 andYValue:10]];
    [points addObject:[[SFPoint alloc] initWithXValue:101 andYValue:1]];
    [points addObject:[[SFPoint alloc] initWithXValue:101 andYValue:10]];
    SFLineString *lineString = [[SFLineString alloc] initWithPoints:points];
    [lineStrings addObject:lineString];
    SFMultiLineString *mls = [[SFMultiLineString alloc] initWithLineStrings:lineStrings];
    [SFGTestUtils compareSFGeometry:mls withInput:MULTILINESTRING];
}

-(void) testSerializeSFMultiLineStringWithAltitude{
    NSMutableArray<SFLineString *> *lineStrings = [[NSMutableArray alloc] init];
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:100 andYValue:10 andZValue:5]];
    [points addObject:[[SFPoint alloc] initWithXValue:101 andYValue:1 andZValue:10]];
    [points addObject:[[SFPoint alloc] initWithXValue:101 andYValue:10 andZValue:15]];
    SFLineString *lineString = [[SFLineString alloc] initWithPoints:points];
    [lineStrings addObject:lineString];
    SFMultiLineString *mls = [[SFMultiLineString alloc] initWithLineStrings:lineStrings];
    [SFGTestUtils compareSFGeometry:mls withInput:MULTILINESTRING_WITH_ALT];
}

-(void) testSerializeSFMultiLineStringWithMultiple{
    NSMutableArray<SFLineString *> *lineStrings = [[NSMutableArray alloc] init];
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:-100 andYValue:-50]];
    [points addObject:[[SFPoint alloc] initWithXValue:100 andYValue:-50]];
    [points addObject:[[SFPoint alloc] initWithXValue:1 andYValue:50]];
    SFLineString *lineString = [[SFLineString alloc] initWithPoints:points];
    [lineStrings addObject:lineString];
    points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:-50 andYValue:-25]];
    [points addObject:[[SFPoint alloc] initWithXValue:50 andYValue:-25]];
    [points addObject:[[SFPoint alloc] initWithXValue:-1 andYValue:25]];
    lineString = [[SFLineString alloc] initWithPoints:points];
    [lineStrings addObject:lineString];
    SFMultiLineString *mls = [[SFMultiLineString alloc] initWithLineStrings:lineStrings];
    [SFGTestUtils compareSFGeometry:mls withInput:MULTILINESTRING_WITH_MULTIPLE];
}

-(void) testDeserializeMultiLineString{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:MULTILINESTRING];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGMultiLineString class]];
    SFGMultiLineString *gjMultiLineString = (SFGMultiLineString *) object;
    SFGeometry *geometry = [gjMultiLineString geometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFMultiLineString class]];
    SFMultiLineString *multiLineString = (SFMultiLineString *) geometry;
    NSArray<SFLineString *> *lineStrings = [multiLineString lineStrings];
    [SFGTestUtils assertTrue:lineStrings.count == 1];
    SFLineString *lineString = [lineStrings objectAtIndex:0];
    NSArray<SFPoint *> *points = lineString.points;
    [SFGTestUtils assertSimplePointWithLongitude:100 andLatitude:10 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:0]];
    [SFGTestUtils assertSimplePointWithLongitude:101 andLatitude:1 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:1]];
    [SFGTestUtils assertSimplePointWithLongitude:101 andLatitude:10 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:2]];
}

-(void) testDeserializeMultiLineStringWithAltitude{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:MULTILINESTRING_WITH_ALT];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGMultiLineString class]];
    SFGMultiLineString *gjMultiLineString = (SFGMultiLineString *) object;
    SFGeometry *geometry = [gjMultiLineString geometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFMultiLineString class]];
    SFMultiLineString *multiLineString = (SFMultiLineString *) geometry;
    NSArray<SFLineString *> *lineStrings = [multiLineString lineStrings];
    [SFGTestUtils assertTrue:lineStrings.count == 1];
    SFLineString *lineString = [lineStrings objectAtIndex:0];
    NSArray<SFPoint *> *points = lineString.points;
    [SFGTestUtils assertSimplePointWithLongitude:100 andLatitude:10 andAltitude:[NSNumber numberWithDouble:5] andAdditional:nil andSimplePoint:[points objectAtIndex:0]];
    [SFGTestUtils assertSimplePointWithLongitude:101 andLatitude:1 andAltitude:[NSNumber numberWithDouble:10] andAdditional:nil andSimplePoint:[points objectAtIndex:1]];
    [SFGTestUtils assertSimplePointWithLongitude:101 andLatitude:10 andAltitude:[NSNumber numberWithDouble:15] andAdditional:nil andSimplePoint:[points objectAtIndex:2]];
}

-(void) testDeserializeMultiLineStringWithMultiple{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:MULTILINESTRING_WITH_MULTIPLE];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGMultiLineString class]];
    SFGMultiLineString *gjMultiLineString = (SFGMultiLineString *) object;
    SFGeometry *geometry = [gjMultiLineString geometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFMultiLineString class]];
    SFMultiLineString *multiLineString = (SFMultiLineString *) geometry;
    NSArray<SFLineString *> *lineStrings = [multiLineString lineStrings];
    [SFGTestUtils assertTrue:lineStrings.count == 2];
    SFLineString *lineString = [lineStrings objectAtIndex:0];
    NSArray<SFPoint *> *points = lineString.points;
    [SFGTestUtils assertSimplePointWithLongitude:-100 andLatitude:-50 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:0]];
    [SFGTestUtils assertSimplePointWithLongitude:100 andLatitude:-50 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:1]];
    [SFGTestUtils assertSimplePointWithLongitude:1 andLatitude:50 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:2]];
    lineString = [lineStrings objectAtIndex:1];
    points = lineString.points;
    [SFGTestUtils assertSimplePointWithLongitude:-50 andLatitude:-25 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:0]];
    [SFGTestUtils assertSimplePointWithLongitude:50 andLatitude:-25 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:1]];
    [SFGTestUtils assertSimplePointWithLongitude:-1 andLatitude:25 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:2]];
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
    
    NSMutableArray<SFLineString *> *lineStrings = [[NSMutableArray alloc] init];
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:100.0 andYValue:10.0]];
    [points addObject:[[SFPoint alloc] initWithXValue:101.0 andYValue:1.0]];
    [points addObject:[[SFPoint alloc] initWithXValue:101.0 andYValue:10.0]];
    SFLineString *lineString = [[SFLineString alloc] initWithPoints:points];
    [lineStrings addObject:lineString];
    SFMultiLineString *mls = [[SFMultiLineString alloc] initWithLineStrings:lineStrings];
    
    return mls;
}

@end
