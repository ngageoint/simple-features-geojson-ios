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

-(void) testSerializePoint{
    SFPoint *simplePoint = [SFPoint pointWithXValue:100 andYValue:10];
    [SFGTestUtils compareSFGeometry:simplePoint withInput:@"{\"type\":\"Point\",\"coordinates\":[100,10]}"];
}

-(void) testDeserializePoint{
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
    SFPoint *simplePoint = [SFPoint pointWithXValue:100 andYValue:10 andZValue:256];
    [SFGTestUtils compareSFGeometry:simplePoint withInput:@"{\"type\":\"Point\",\"coordinates\":[100,10,256]}"];
}

-(void) testDeserializePointWithAdditionalAttributes{
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:@"{\"type\":\"Point\",\"coordinates\":[100,5,123,456,789.2]}"];
    SFGPoint *point = (SFGPoint *) object;
    [SFGTestUtils assertPointWithLongitude:100 andLatitude:5 andAltitude:[NSNumber numberWithDouble:123] andAdditional:[NSArray arrayWithObjects:[NSNumber numberWithDouble:456], [NSNumber numberWithDouble:789.2], nil] andPoint:point];
}

-(void) testSerializePointWithAdditionalAttributes{
    SFGPosition *position = [SFGPosition positionWithLongitudeValue:100.2 andLatitudeValue:0.0 andAltitudeValue:256.0 andAdditionals:[NSArray arrayWithObjects:[[NSDecimalNumber alloc] initWithDouble:345], [[NSDecimalNumber alloc] initWithDouble:678], nil]];
    SFGPoint *point = [SFGPoint pointWithPosition:position];
    [SFGTestUtils compareGeometry:point withInput:@"{\"type\":\"Point\",\"coordinates\":[100.2,0,256,345,678]}"];
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
    return [SFPoint pointWithXValue:100 andYValue:10];
}

@end
