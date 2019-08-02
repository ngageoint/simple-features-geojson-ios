//
//  SFGPolygonTestCase.m
//  sf-geojson-iosTests
//
//  Created by Brian Osborn on 8/1/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGPolygonTestCase.h"
#import "SFGTestUtils.h"
#import "SFLineString.h"
#import "SFLinearRing.h"
#import "SFPolygon.h"
#import "SFGFeatureConverter.h"

@implementation SFGPolygonTestCase

static NSString *POLYGON = @"{\"type\":\"Polygon\",\"coordinates\":[[[100,10.1],[101.2,1.3],[101.4,10.5],[100,10.1]]]}";
static NSString *POLYGON_WITH_ALT = @"{\"type\":\"Polygon\",\"coordinates\":[[[100,10.1,5.2],[101.3,1.4,10.5],[101.6,10.7,15.8],[100,10.1,5.2]]]}";
static NSString *POLYGON_WITH_RINGS = @"{\"type\":\"Polygon\",\"coordinates\":[[[-100,-50],[100,-50],[1,50],[-100,-50]],[[-50,-25],[50,-25],[-1,25],[-50,-25]]]}";

-(void) testSerializePolygon{
    NSMutableArray<SFLineString *> *rings = [[NSMutableArray alloc] init];
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:100 andYValue:10.1]];
    [points addObject:[[SFPoint alloc] initWithXValue:101.2 andYValue:1.3]];
    [points addObject:[[SFPoint alloc] initWithXValue:101.4 andYValue:10.5]];
    SFLinearRing *ring = [[SFLinearRing alloc] initWithPoints:points];
    [rings addObject:ring];
    SFPolygon *polygon = [[SFPolygon alloc] initWithRings:rings];
    [SFGTestUtils compareSFGeometry:polygon withInput:POLYGON];
}

-(void) testSerializePolygonWithAltitude{
    NSMutableArray<SFLineString *> *rings = [[NSMutableArray alloc] init];
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:100 andYValue:10.1 andZValue:5.2]];
    [points addObject:[[SFPoint alloc] initWithXValue:101.3 andYValue:1.4 andZValue:10.5]];
    [points addObject:[[SFPoint alloc] initWithXValue:101.6 andYValue:10.7 andZValue:15.8]];
    SFLinearRing *ring = [[SFLinearRing alloc] initWithPoints:points];
    [rings addObject:ring];
    SFPolygon *polygon = [[SFPolygon alloc] initWithRings:rings];
    [SFGTestUtils compareSFGeometry:polygon withInput:POLYGON_WITH_ALT];
}

-(void) testSerializePolygonWithRings{
    NSMutableArray<SFLineString *> *rings = [[NSMutableArray alloc] init];
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:-100.0 andYValue:-50]];
    [points addObject:[[SFPoint alloc] initWithXValue:100 andYValue:-50]];
    [points addObject:[[SFPoint alloc] initWithXValue:1 andYValue:50]];
    SFLinearRing *ring = [[SFLinearRing alloc] initWithPoints:points];
    [rings addObject:ring];
    points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:-50 andYValue:-25]];
    [points addObject:[[SFPoint alloc] initWithXValue:50 andYValue:-25]];
    [points addObject:[[SFPoint alloc] initWithXValue:-1 andYValue:25]];
    ring = [[SFLinearRing alloc] initWithPoints:points];
    [rings addObject:ring];
    SFPolygon *polygon = [[SFPolygon alloc] initWithRings:rings];
    [SFGTestUtils compareSFGeometry:polygon withInput:POLYGON_WITH_RINGS];
}

-(void) testDeserializePolygon{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:POLYGON];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGPolygon class]];
    SFGPolygon *gjPolygon = (SFGPolygon *) object;
    SFGeometry *geometry = [gjPolygon geometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFPolygon class]];
    SFPolygon *polygon = (SFPolygon *) geometry;
    NSArray<SFLineString *> *rings = polygon.lineStrings;
    [SFGTestUtils assertTrue:rings.count == 1];
    SFLineString *ring = [rings objectAtIndex:0];
    NSArray<SFPoint *> *points = ring.points;
    [SFGTestUtils assertSimplePointWithLongitude:100 andLatitude:10.1 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:0]];
    [SFGTestUtils assertSimplePointWithLongitude:101.2 andLatitude:1.3 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:1]];
    [SFGTestUtils assertSimplePointWithLongitude:101.4 andLatitude:10.5 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:2]];
    [SFGTestUtils assertSimplePointWithLongitude:100 andLatitude:10.1 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:3]];
}

-(void) testDeserializePolygonWithAltitude{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:POLYGON_WITH_ALT];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGPolygon class]];
    SFGPolygon *gjPolygon = (SFGPolygon *) object;
    SFGeometry *geometry = [gjPolygon geometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFPolygon class]];
    SFPolygon *polygon = (SFPolygon *) geometry;
    NSArray<SFLineString *> *rings = polygon.lineStrings;
    [SFGTestUtils assertTrue:rings.count == 1];
    SFLineString *ring = [rings objectAtIndex:0];
    NSArray<SFPoint *> *points = ring.points;
    [SFGTestUtils assertSimplePointWithLongitude:100 andLatitude:10.1 andAltitude:[NSNumber numberWithDouble:5.2] andAdditional:nil andSimplePoint:[points objectAtIndex:0]];
    [SFGTestUtils assertSimplePointWithLongitude:101.3 andLatitude:1.4 andAltitude:[NSNumber numberWithDouble:10.5] andAdditional:nil andSimplePoint:[points objectAtIndex:1]];
    [SFGTestUtils assertSimplePointWithLongitude:101.6 andLatitude:10.7 andAltitude:[NSNumber numberWithDouble:15.8] andAdditional:nil andSimplePoint:[points objectAtIndex:2]];
    [SFGTestUtils assertSimplePointWithLongitude:100 andLatitude:10.1 andAltitude:[NSNumber numberWithDouble:5.2] andAdditional:nil andSimplePoint:[points objectAtIndex:3]];
}

-(void) testDeserializePolygonWithRings{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:POLYGON_WITH_RINGS];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGPolygon class]];
    SFGPolygon *gjPolygon = (SFGPolygon *) object;
    SFGeometry *geometry = [gjPolygon geometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFPolygon class]];
    SFPolygon *polygon = (SFPolygon *) geometry;
    NSArray<SFLineString *> *rings = polygon.lineStrings;
    [SFGTestUtils assertTrue:rings.count == 2];
    SFLineString *ring = [rings objectAtIndex:0];
    NSArray<SFPoint *> *points = ring.points;
    [SFGTestUtils assertSimplePointWithLongitude:-100 andLatitude:-50 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:0]];
    [SFGTestUtils assertSimplePointWithLongitude:100 andLatitude:-50 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:1]];
    [SFGTestUtils assertSimplePointWithLongitude:1 andLatitude:50 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:2]];
    [SFGTestUtils assertSimplePointWithLongitude:-100 andLatitude:-50 andAltitude:nil andAdditional:nil andSimplePoint:[points objectAtIndex:3]];
    ring = [rings objectAtIndex:1];
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
    
    NSMutableArray<SFLineString *> *rings = [[NSMutableArray alloc] init];
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:-100.0 andYValue:-50]];
    [points addObject:[[SFPoint alloc] initWithXValue:100 andYValue:-50]];
    [points addObject:[[SFPoint alloc] initWithXValue:1 andYValue:50]];
    SFLinearRing *ring = [[SFLinearRing alloc] initWithPoints:points];
    [rings addObject:ring];
    points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:-50 andYValue:-25]];
    [points addObject:[[SFPoint alloc] initWithXValue:50 andYValue:-25]];
    [points addObject:[[SFPoint alloc] initWithXValue:-1 andYValue:25]];
    ring = [[SFLinearRing alloc] initWithPoints:points];
    [rings addObject:ring];
    SFPolygon *polygon = [[SFPolygon alloc] initWithRings:rings];
    
    return polygon;
}

@end
