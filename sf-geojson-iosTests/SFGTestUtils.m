//
//  SFGTestUtils.m
//  sf-geojson-iosTests
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGTestUtils.h"
#import "SFGFeatureConverter.h"
#import "SFGGeometryTestUtils.h"
#import "SFLinearRing.h"

#define ARC4RANDOM_MAX      0x100000000

@implementation SFGTestUtils

+(void) compareSFGeometry: (SFGeometry *) simpleGeometry withInput: (NSString *) json{
    SFGGeometry *geometry = [SFGFeatureConverter simpleGeometryToGeometry:simpleGeometry];
    [self compareGeometry:geometry withInput:json];
}

+(void) compareGeometry: (SFGGeometry *) geometry withInput: (NSString *) json{
    NSDictionary *treeFromGeometry = [geometry toTree];
    NSDictionary *treeFromJSON = [SFGFeatureConverter jsonToTree:json];
    [self assertTrue:[treeFromGeometry isEqualToDictionary:treeFromJSON]];
    NSString *jsonFromTree = [SFGFeatureConverter treeToJSON:treeFromJSON];
    [self assertEqualWithValue:json andValue2:jsonFromTree];
    SFGGeometry *geometryFromTree = [SFGFeatureConverter treeToGeometry:treeFromJSON];
    [self assertEqualWithValue:[geometry type] andValue2:[geometryFromTree type]];
    [self assertEqualWithValue:[geometry coordinates] andValue2:[geometryFromTree coordinates]];
    [self assertEqualWithValue:[[geometry type] uppercaseString] andValue2:[SFGeometryTypes name:[geometry geometry].geometryType]];
    [SFGGeometryTestUtils compareGeometriesWithExpected:[geometry geometry] andActual:[geometryFromTree geometry]];
}

+(SFMultiPolygon *) multiPolygonWithRings{

    NSMutableArray<SFPolygon *> *polygons = [[NSMutableArray alloc] init];
    NSMutableArray<SFLineString *> *rings = [[NSMutableArray alloc] init];
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:-100 andYValue:-50]];
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
    [polygons addObject:polygon];
    SFMultiPolygon *multiPolygon = [[SFMultiPolygon alloc] initWithPolygons:polygons];
    
    return multiPolygon;
}

+(void)assertNil:(id) value{
    if(value != nil){
        [NSException raise:@"Assert Nil" format:@"Value is not nil: %@", value];
    }
}

+(void)assertNotNil:(id) value{
    if(value == nil){
        [NSException raise:@"Assert Not Nil" format:@"Value is nil: %@", value];
    }
}

+(void)assertTrue: (BOOL) value{
    if(!value){
        [NSException raise:@"Assert True" format:@"Value is false"];
    }
}

+(void)assertFalse: (BOOL) value{
    if(value){
        [NSException raise:@"Assert False" format:@"Value is true"];
    }
}

+(void)assertEqualWithValue:(NSObject *) value andValue2: (NSObject *) value2{
    if(value == nil){
        if(value2 != nil){
            [NSException raise:@"Assert Equal" format:@"Value 1: '%@' is not equal to Value 2: '%@'", value, value2];
        }
    } else if(![value isEqual:value2]){
        [NSException raise:@"Assert Equal" format:@"Value 1: '%@' is not equal to Value 2: '%@'", value, value2];
    }
}

+(void)assertEqualBoolWithValue:(BOOL) value andValue2: (BOOL) value2{
    if(value != value2){
        [NSException raise:@"Assert Equal BOOL" format:@"Value 1: '%d' is not equal to Value 2: '%d'", value, value2];
    }
}

+(void)assertEqualIntWithValue:(int) value andValue2: (int) value2{
    if(value != value2){
        [NSException raise:@"Assert Equal int" format:@"Value 1: '%d' is not equal to Value 2: '%d'", value, value2];
    }
}

+(void)assertEqualDoubleWithValue:(double) value andValue2: (double) value2{
    if(value != value2){
        [NSException raise:@"Assert Equal double" format:@"Value 1: '%f' is not equal to Value 2: '%f'", value, value2];
    }
}

+(void)assertEqualDoubleWithValue:(double) value andValue2: (double) value2 andDelta: (double) delta{
    if(fabsl(value - value2) > delta){
        [NSException raise:@"Assert Equal double" format:@"Value 1: '%f' is not equal to Value 2: '%f' within delta: '%f'", value, value2, delta];
    }
}

+(NSDecimalNumber *) roundDouble: (double) value{
    return [self roundDouble:value withScale:1];
}

+(NSDecimalNumber *) roundDouble: (double) value withScale: (int) scale{
    NSDecimalNumberHandler *rounder = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    return [[[NSDecimalNumber alloc] initWithDouble:value] decimalNumberByRoundingAccordingToBehavior:rounder];
}

+(int) randomIntLessThan: (int) max{
    return arc4random() % max;
}

+(double) randomDouble{
    return ((double)arc4random() / ARC4RANDOM_MAX);
}

+(double) randomDoubleLessThan: (double) max{
    return [self randomDouble] * max;
}

+(BOOL) coinFlip{
    return [self randomDouble] < .5;
}

@end
