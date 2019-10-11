//
//  SFGMultiPolygonTestCase.m
//  sf-geojson-iosTests
//
//  Created by Brian Osborn on 8/1/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGMultiPolygonTestCase.h"
#import "SFGTestUtils.h"
#import "SFGMultiPolygon.h"
#import "SFGFeatureConverter.h"
#import "SFLinearRing.h"

@implementation SFGMultiPolygonTestCase

static NSString *MULTIPOLYGON = @"{\"type\":\"MultiPolygon\",\"coordinates\":[[[[100,10],[101,1],[101,10],[100,10]]]]}";
static NSString *MULTIPOLYGON_WITH_ALT = @"{\"type\":\"MultiPolygon\",\"coordinates\":[[[[100,10,5],[101,1,10],[101,10,15],[100,10,5]]]]}";
static NSString *MULTIPOLYGON_WITH_RINGS = @"{\"type\":\"MultiPolygon\",\"coordinates\":[[[[-100,-50],[100,-50],[1.5,50],[-100,-50]],[[-50,-25],[50,-25],[-1,25],[-50,-25]]]]}";
static NSString *MULTIPOLYGON_WITH_MULTI = @"{\"type\":\"MultiPolygon\",\"coordinates\":[[[[-100,-50],[100,-50],[1,50],[-100,-50]]],[[[-50,-25],[50,-25],[-1,25],[-50,-25]]]]}";

-(void) testSerializeMultiPolygon{
    NSMutableArray<SFPolygon *> *polygons = [[NSMutableArray alloc] init];
    NSMutableArray<SFLineString *> *rings = [[NSMutableArray alloc] init];
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:100 andYValue:10]];
    [points addObject:[[SFPoint alloc] initWithXValue:101 andYValue:1]];
    [points addObject:[[SFPoint alloc] initWithXValue:101 andYValue:10]];
    SFLinearRing *ring = [[SFLinearRing alloc] initWithPoints:points];
    [rings addObject:ring];
    SFPolygon *polygon = [[SFPolygon alloc] initWithRings:rings];
    [polygons addObject:polygon];
    SFMultiPolygon *multiPolygon = [[SFMultiPolygon alloc] initWithPolygons:polygons];
    [SFGTestUtils compareSFGeometry:multiPolygon withInput:MULTIPOLYGON];
}

-(void) testSerializeMultiPolygonWithAltitude{
    NSMutableArray<SFPolygon *> *polygons = [[NSMutableArray alloc] init];
    NSMutableArray<SFLineString *> *rings = [[NSMutableArray alloc] init];
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:100 andYValue:10 andZValue:5]];
    [points addObject:[[SFPoint alloc] initWithXValue:101 andYValue:1 andZValue:10]];
    [points addObject:[[SFPoint alloc] initWithXValue:101 andYValue:10 andZValue:15]];
    SFLinearRing *ring = [[SFLinearRing alloc] initWithPoints:points];
    [rings addObject:ring];
    SFPolygon *polygon = [[SFPolygon alloc] initWithRings:rings];
    [polygons addObject:polygon];
    SFMultiPolygon *multiPolygon = [[SFMultiPolygon alloc] initWithPolygons:polygons];
    [SFGTestUtils compareSFGeometry:multiPolygon withInput:MULTIPOLYGON_WITH_ALT];
}

-(void) testSerializeMultiPolygonWithRings{
    [SFGTestUtils compareSFGeometry:[SFGTestUtils multiPolygonWithRings] withInput:MULTIPOLYGON_WITH_RINGS];
}

-(void) testSerializeMultiPolygonWithMulti{
    NSMutableArray<SFPolygon *> *polygons = [[NSMutableArray alloc] init];
    
    NSMutableArray<SFLineString *> *rings = [[NSMutableArray alloc] init];
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:-100 andYValue:-50]];
    [points addObject:[[SFPoint alloc] initWithXValue:100 andYValue:-50]];
    [points addObject:[[SFPoint alloc] initWithXValue:1 andYValue:50]];
    SFLinearRing *ring = [[SFLinearRing alloc] initWithPoints:points];
    [rings addObject:ring];
    SFPolygon *polygon = [[SFPolygon alloc] initWithRings:rings];
    [polygons addObject:polygon];
    
    rings = [[NSMutableArray alloc] init];
    points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:-50 andYValue:-25]];
    [points addObject:[[SFPoint alloc] initWithXValue:50 andYValue:-25]];
    [points addObject:[[SFPoint alloc] initWithXValue:-1 andYValue:25]];
    ring = [[SFLinearRing alloc] initWithPoints:points];
    [rings addObject:ring];
    polygon = [[SFPolygon alloc] initWithRings:rings];
    [polygons addObject:polygon];
    
    SFMultiPolygon *multiPolygon = [[SFMultiPolygon alloc] initWithPolygons:polygons];
    [SFGTestUtils compareSFGeometry:multiPolygon withInput:MULTIPOLYGON_WITH_MULTI];
}

-(void) testDeserializeMultiPolygon{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:MULTIPOLYGON];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGMultiPolygon class]];
    SFGMultiPolygon *gjMultiPolygon = (SFGMultiPolygon *) object;
    SFGeometry *geometry = [gjMultiPolygon geometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFMultiPolygon class]];
    SFMultiPolygon *multiPolygon = (SFMultiPolygon *) geometry;
    NSArray<SFPolygon *> *polygons = [multiPolygon polygons];
    [SFGTestUtils assertTrue:polygons.count == 1];
    SFPolygon *polygon = [polygons objectAtIndex:0];
    NSMutableArray<SFLineString *> *rings = [polygon lineStrings];
    [SFGTestUtils assertTrue:rings.count == 1];
    SFLineString *ring = [rings objectAtIndex:0];
    NSArray<SFPoint *> *points = ring.points;
    [SFGTestUtils assertSimplePointWithLongitude:100 andLatitude:10 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:0]];
    [SFGTestUtils assertSimplePointWithLongitude:101 andLatitude:1 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:1]];
    [SFGTestUtils assertSimplePointWithLongitude:101 andLatitude:10 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:2]];
    [SFGTestUtils assertSimplePointWithLongitude:100 andLatitude:10 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:3]];
}

-(void) testDeserializeMultiPolygonWithAltitude{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:MULTIPOLYGON_WITH_ALT];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGMultiPolygon class]];
    SFGMultiPolygon *gjMultiPolygon = (SFGMultiPolygon *) object;
    SFGeometry *geometry = [gjMultiPolygon geometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFMultiPolygon class]];
    SFMultiPolygon *multiPolygon = (SFMultiPolygon *) geometry;
    NSArray<SFPolygon *> *polygons = [multiPolygon polygons];
    [SFGTestUtils assertTrue:polygons.count == 1];
    SFPolygon *polygon = [polygons objectAtIndex:0];
    NSMutableArray<SFLineString *> *rings = [polygon lineStrings];
    [SFGTestUtils assertTrue:rings.count == 1];
    SFLineString *ring = [rings objectAtIndex:0];
    NSArray<SFPoint *> *points = ring.points;
    [SFGTestUtils assertSimplePointWithLongitude:100 andLatitude:10 andAltitude:[NSNumber numberWithDouble:5] andAdditional:nil andSimplePoint:[points objectAtIndex:0]];
    [SFGTestUtils assertSimplePointWithLongitude:101 andLatitude:1 andAltitude:[NSNumber numberWithDouble:10] andAdditional:nil andSimplePoint:[points objectAtIndex:1]];
    [SFGTestUtils assertSimplePointWithLongitude:101 andLatitude:10 andAltitude:[NSNumber numberWithDouble:15] andAdditional:nil andSimplePoint:[points objectAtIndex:2]];
    [SFGTestUtils assertSimplePointWithLongitude:100 andLatitude:10 andAltitude:[NSNumber numberWithDouble:5] andAdditional:nil andSimplePoint:[points objectAtIndex:3]];
}

-(void) testDeserializeMultiPolygonWithRings{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:MULTIPOLYGON_WITH_RINGS];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGMultiPolygon class]];
    SFGMultiPolygon *gjMultiPolygon = (SFGMultiPolygon *) object;
    SFGeometry *geometry = [gjMultiPolygon geometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFMultiPolygon class]];
    SFMultiPolygon *multiPolygon = (SFMultiPolygon *) geometry;
    NSArray<SFPolygon *> *polygons = [multiPolygon polygons];
    [SFGTestUtils assertTrue:polygons.count == 1];
    SFPolygon *polygon = [polygons objectAtIndex:0];
    NSMutableArray<SFLineString *> *rings = [polygon lineStrings];
    [SFGTestUtils assertTrue:rings.count == 2];
    SFLineString *ring = [rings objectAtIndex:0];
    NSArray<SFPoint *> *points = ring.points;
    [SFGTestUtils assertSimplePointWithLongitude:-100 andLatitude:-50 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:0]];
    [SFGTestUtils assertSimplePointWithLongitude:100 andLatitude:-50 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:1]];
    [SFGTestUtils assertSimplePointWithLongitude:1.5 andLatitude:50 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:2]];
    [SFGTestUtils assertSimplePointWithLongitude:-100 andLatitude:-50 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:3]];
    ring = [rings objectAtIndex:1];
    points = ring.points;
    [SFGTestUtils assertSimplePointWithLongitude:-50 andLatitude:-25 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:0]];
    [SFGTestUtils assertSimplePointWithLongitude:50 andLatitude:-25 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:1]];
    [SFGTestUtils assertSimplePointWithLongitude:-1 andLatitude:25 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:2]];
    [SFGTestUtils assertSimplePointWithLongitude:-50 andLatitude:-25 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:3]];
}

-(void) testDeserializeMultiPolygonWithMulti{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:MULTIPOLYGON_WITH_MULTI];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGMultiPolygon class]];
    SFGMultiPolygon *gjMultiPolygon = (SFGMultiPolygon *) object;
    SFGeometry *geometry = [gjMultiPolygon geometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFMultiPolygon class]];
    SFMultiPolygon *multiPolygon = (SFMultiPolygon *) geometry;
    NSArray<SFPolygon *> *polygons = [multiPolygon polygons];
    [SFGTestUtils assertTrue:polygons.count == 2];
    SFPolygon *polygon = [polygons objectAtIndex:0];
    NSMutableArray<SFLineString *> *rings = [polygon lineStrings];
    [SFGTestUtils assertTrue:rings.count == 1];
    SFLineString *ring = [rings objectAtIndex:0];
    NSArray<SFPoint *> *points = ring.points;
    [SFGTestUtils assertSimplePointWithLongitude:-100 andLatitude:-50 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:0]];
    [SFGTestUtils assertSimplePointWithLongitude:100 andLatitude:-50 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:1]];
    [SFGTestUtils assertSimplePointWithLongitude:1 andLatitude:50 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:2]];
    [SFGTestUtils assertSimplePointWithLongitude:-100 andLatitude:-50 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:3]];
    polygon = [polygons objectAtIndex:1];
    rings = [polygon lineStrings];
    [SFGTestUtils assertTrue:rings.count == 1];
    ring = [rings objectAtIndex:0];
    points = ring.points;
    [SFGTestUtils assertSimplePointWithLongitude:-50 andLatitude:-25 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:0]];
    [SFGTestUtils assertSimplePointWithLongitude:50 andLatitude:-25 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:1]];
    [SFGTestUtils assertSimplePointWithLongitude:-1 andLatitude:25 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:2]];
    [SFGTestUtils assertSimplePointWithLongitude:-50 andLatitude:-25 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:3]];
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
    
    NSMutableArray<SFPolygon *> *polygons = [[NSMutableArray alloc] init];
    NSMutableArray<SFLineString *> *rings = [[NSMutableArray alloc] init];
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:100.0 andYValue:10.0]];
    [points addObject:[[SFPoint alloc] initWithXValue:101.0 andYValue:1.0]];
    [points addObject:[[SFPoint alloc] initWithXValue:101.0 andYValue:10.0]];
    SFLinearRing *ring = [[SFLinearRing alloc] initWithPoints:points];
    [rings addObject:ring];
    SFPolygon *polygon = [[SFPolygon alloc] initWithRings:rings];
    [polygons addObject:polygon];
    SFMultiPolygon *multiPolygon = [[SFMultiPolygon alloc] initWithPolygons:polygons];
    
    return multiPolygon;
}

@end
