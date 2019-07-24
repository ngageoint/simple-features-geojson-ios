//
//  SFGPointTestCase.m
//  sf-geojson-iosTests
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGPointTestCase.h"
#import "SFGTestUtils.h"
#import "SFPoint.h"
#import "SFGFeatureConverter.h"

@implementation SFGPointTestCase

-(void) testSerializeSFPoint{
    SFPoint *simplePoint = [[SFPoint alloc] initWithXValue:100 andYValue:10];
    [SFGTestUtils compareSFGeometry:simplePoint withInput:@"{\"type\":\"Point\",\"coordinates\":[100,10]}"];
}

-(void) testSerializePoint{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:@"{\"type\":\"Point\",\"coordinates\":[100.0,5.0]}"];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGPoint class]];
    SFGPoint *point = (SFGPoint *) object;
    [SFGTestUtils assertPointWithLongitude:100 andLatitude:5 andAltitude:nil andPoint:point];
}

-(void) testDeserializePointWithAltitude{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:@"{\"type\":\"Point\",\"coordinates\":[100.9,5.8,123.7]}"];
    SFGPoint *point = (SFGPoint *) object;
    [SFGTestUtils assertPointWithLongitude:100.9 andLatitude:5.8 andAltitude:[NSNumber numberWithDouble:123.7] andPoint:point];
}

-(void) testSerializePointWithAltitude{
    SFPoint *simplePoint = [[SFPoint alloc] initWithXValue:100.1 andYValue:10.2 andZValue:256.3];
    [SFGTestUtils compareSFGeometry:simplePoint withInput:@"{\"type\":\"Point\",\"coordinates\":[100.1,10.2,256.3]}"];
}

-(void) testDeserializePointWithAdditionalAttributes{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:@"{\"type\":\"Point\",\"coordinates\":[100,5,123,456,789.2]}"];
    SFGPoint *point = (SFGPoint *) object;
    [SFGTestUtils assertPointWithLongitude:100 andLatitude:5 andAltitude:[NSNumber numberWithDouble:123] andAdditional:[[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:456], [NSNumber numberWithDouble:789.2], nil] andPoint:point];
}

-(void) testSerializePointWithAdditionalAttributes{
    SFGPosition *position = [[SFGPosition alloc] initWithLongitude:[NSNumber numberWithDouble:100.2] andLatitude:[NSNumber numberWithDouble:0] andAltitude:[NSNumber numberWithDouble:256] andAdditionals:[[NSArray alloc] initWithObjects:[NSNumber numberWithDouble:345.3], [NSNumber numberWithDouble:678.6], nil]];
    SFGPoint *point = [[SFGPoint alloc] initWithPosition:position];
    [SFGTestUtils compareGeometry:point withInput:@"{\"type\":\"Point\",\"coordinates\":[100.2,0,256,345.3,678.6]}"];
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
    return [[SFPoint alloc] initWithXValue:100 andYValue:10];
}

@end
