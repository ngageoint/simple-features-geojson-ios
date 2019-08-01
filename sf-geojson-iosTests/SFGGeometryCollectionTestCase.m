//
//  SFGGeometryCollectionTestCase.m
//  sf-geojson-iosTests
//
//  Created by Brian Osborn on 8/1/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometryCollectionTestCase.h"
#import "SFGTestUtils.h"
#import "SFGeometryCollection.h"
#import "SFPoint.h"
#import "SFLineString.h"

@implementation SFGGeometryCollectionTestCase

static NSString *GEOMETRYCOLLECTION = @"{\"type\":\"GeometryCollection\",\"geometries\":[{\"type\":\"Point\",\"coordinates\":[61.5,48.8]},{\"type\":\"LineString\",\"coordinates\":[[100,10],[101,1]]}]}";
static NSString *GEOMETRYCOLLECTION_WITH_ALT = @"{\"type\":\"GeometryCollection\",\"geometries\":[{\"type\":\"Point\",\"coordinates\":[61.34765625,48.63290858589535, 12.7843]},{\"type\":\"LineString\",\"coordinates\":[[100.0,10.0,5.0],[101.0,1.0,10.0]]}]}";

-(void) testSerializeSFGeometryCollection{
    SFGeometry *geometryCollection = [self createTestGeometry];
    [SFGTestUtils compareSFGeometry:geometryCollection withInput:GEOMETRYCOLLECTION];
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
    
    SFGeometryCollection *geometryCollection = [[SFGeometryCollection alloc] init];
    SFPoint *point = [[SFPoint alloc] initWithXValue:61.5 andYValue:48.8];
    [geometryCollection addGeometry:point];
    SFLineString *lineString = [[SFLineString alloc] init];
    [lineString addPoint:[[SFPoint alloc] initWithXValue:100.0 andYValue:10.0]];
    [lineString addPoint:[[SFPoint alloc] initWithXValue:101.0 andYValue:1.0]];
    [geometryCollection addGeometry:lineString];
    
    return geometryCollection;
}

@end
