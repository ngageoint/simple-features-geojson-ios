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

static double EPSILON = 0.00001;

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

+(void) assertPointWithLongitude: (double) longitude andLatitude: (double) latitude andAltitude: (NSNumber *) altitude andPoint: (SFGPoint *) point{
    [self assertPointWithLongitude:longitude andLatitude:latitude andAltitude:altitude andAdditional:nil andPoint:point];
}

+(void) assertPointWithLongitude: (double) longitude andLatitude: (double) latitude andAltitude: (NSNumber *) altitude andAdditional: (NSArray<NSNumber *> *) additionalElements andPoint: (SFGPoint *) point{
    [self assertPositionWithLongitude:longitude andLatitude:latitude andAltitude:altitude andAdditional:additionalElements andPosition:point.position];
}

+(void) assertPositionWithLongitude: (double) longitude andLatitude: (double) latitude andAltitude: (NSNumber *) altitude andAdditional: (NSArray<NSNumber *> *) additionalElements andCoordinates: (NSArray *) coordinates{
    [self assertPositionWithLongitude:longitude andLatitude:latitude andAltitude:altitude andAdditional:additionalElements andPosition:[[SFGPosition alloc] initWithCoordinates:coordinates]];
}

+(void) assertPositionWithLongitude: (double) longitude andLatitude: (double) latitude andAltitude: (NSNumber *) altitude andAdditional: (NSArray<NSNumber *> *) additionalElements andPosition: (SFGPosition *) position{
    [self assertEqualDoubleWithValue:longitude andValue2:[[position x] doubleValue] andDelta:EPSILON];
    [self assertEqualDoubleWithValue:latitude andValue2:[[position y] doubleValue] andDelta:EPSILON];
    if(altitude == nil){
        [self assertNil:[position z]];
    }else{
        [self assertEqualDoubleWithValue:[altitude doubleValue] andValue2:[[position z] doubleValue] andDelta:EPSILON];
        if(additionalElements == nil || additionalElements.count == 0){
            NSArray<NSDecimalNumber *> *ae = [position additionalElements];
            [self assertTrue:ae == nil || ae.count == 0];
        }else{
            [self assertEqualDoubleWithValue:[[additionalElements objectAtIndex:0] doubleValue] andValue2:[[position m] doubleValue] andDelta:EPSILON];
        }
    }
}

+(void) assertSimplePointWithLongitude: (double) longitude andLatitude: (double) latitude andAltitude: (NSNumber *) altitude andAdditional: (NSArray<NSNumber *> *) additionalElements andSimplePoint: (SFPoint *) point{
    [self assertEqualDoubleWithValue:longitude andValue2:[point.x doubleValue] andDelta:EPSILON];
    [self assertEqualDoubleWithValue:latitude andValue2:[point.y doubleValue] andDelta:EPSILON];
    if(altitude == nil){
        [self assertNil:point.z];
    }else{
        [self assertEqualDoubleWithValue:[altitude doubleValue] andValue2:[point.z doubleValue] andDelta:EPSILON];
        if(additionalElements == nil || additionalElements.count == 0){
            [self assertNil:point.m];
        }else{
            [self assertEqualIntWithValue:1 andValue2:(int)additionalElements.count];
            [self assertEqualDoubleWithValue:[[additionalElements objectAtIndex:0] doubleValue] andValue2:[point.m doubleValue] andDelta:EPSILON];
        }
    }
}

+(SFMultiPolygon *) multiPolygonWithRings{

    NSMutableArray<SFPolygon *> *polygons = [[NSMutableArray alloc] init];
    NSMutableArray<SFLineString *> *rings = [[NSMutableArray alloc] init];
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    [points addObject:[[SFPoint alloc] initWithXValue:-100 andYValue:-50]];
    [points addObject:[[SFPoint alloc] initWithXValue:100 andYValue:-50]];
    [points addObject:[[SFPoint alloc] initWithXValue:1.5 andYValue:50]];
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

+(void) simpleGeometryToGeometry: (SFGeometry *) simpleGeometry{
    
    SFGGeometry *geometry = [SFGFeatureConverter simpleGeometryToGeometry:simpleGeometry];
    [SFGTestUtils assertNotNil:geometry];
    
    [SFGTestUtils assertTrue:[simpleGeometry isEqual:[geometry geometry]]];
    
}

+(void) simpleGeometryToTree: (SFGeometry *) simpleGeometry{
    
    SFGGeometry *geometry = [SFGFeatureConverter simpleGeometryToGeometry:simpleGeometry];
    [SFGTestUtils assertNotNil:geometry];
    
    NSDictionary *tree = [SFGFeatureConverter simpleGeometryToTree:simpleGeometry];
    [SFGTestUtils assertNotNil:tree];
    [SFGTestUtils assertFalse:tree.count == 0];
    
    SFGGeometry *geometryFromTree = [SFGFeatureConverter treeToGeometry:tree];
    [SFGTestUtils assertNotNil:geometryFromTree];
    
    [SFGTestUtils assertTrue:[[geometry geometry] isEqual:[geometryFromTree geometry]]];
   
    SFGGeoJSONObject *objectFromTree = [SFGFeatureConverter treeToObject:tree];
    [SFGTestUtils assertNotNil:objectFromTree];
    [SFGTestUtils assertTrue:[objectFromTree isKindOfClass:[SFGGeometry class]]];
    
    SFGGeometry *geometryFromTree2 = (SFGGeometry *) objectFromTree;
    [SFGTestUtils assertTrue:[[geometry geometry] isEqual:[geometryFromTree2 geometry]]];
}

+(void) simpleGeometryToJSON: (SFGeometry *) simpleGeometry{
    
    SFGGeometry *geometry = [SFGFeatureConverter simpleGeometryToGeometry:simpleGeometry];
    [SFGTestUtils assertNotNil:geometry];
    
    NSString *json = [SFGFeatureConverter simpleGeometryToJSON:simpleGeometry];
    [SFGTestUtils assertNotNil:json];
    [SFGTestUtils assertFalse:json.length == 0];
    NSString *type = [NSString stringWithFormat:@"\"type\":\"%@\"", [geometry type]];
    int index = (int)[json rangeOfString:type].location;
    [SFGTestUtils assertTrue:index >= 0];
    NSString *restOfString = [json substringFromIndex:index + type.length];
    int secondIndex = (int)[restOfString rangeOfString:type].location;
    [SFGTestUtils assertEqualIntWithValue:-1 andValue2:secondIndex];
    
    SFGGeometry *geometryFromJSON = [SFGFeatureConverter jsonToGeometry:json];
    [SFGTestUtils assertNotNil:geometryFromJSON];
    
    [SFGTestUtils assertTrue:[[geometry geometry] isEqual:[geometryFromJSON geometry]]];

    SFGGeoJSONObject *objectFromJSON = [SFGFeatureConverter jsonToObject:json];
    [SFGTestUtils assertNotNil:objectFromJSON];
    [SFGTestUtils assertTrue:[objectFromJSON isKindOfClass:[SFGGeometry class]]];
    
    SFGGeometry *geometryFromJSON2 = (SFGGeometry *) objectFromJSON;
    [SFGTestUtils assertTrue:[[geometry geometry] isEqual:[geometryFromJSON2 geometry]]];
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
