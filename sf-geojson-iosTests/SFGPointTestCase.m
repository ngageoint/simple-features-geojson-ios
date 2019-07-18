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

@implementation SFGPointTestCase

-(void) testSerializeSFPoint{
    SFPoint *simplePoint = [[SFPoint alloc] initWithXValue:100 andYValue:10];
    [SFGTestUtils compareSFGeometry:simplePoint withInput:@"{\"type\":\"Point\",\"coordinates\":[100,10]}"];
}

@end
