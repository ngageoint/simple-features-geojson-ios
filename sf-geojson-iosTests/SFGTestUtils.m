//
//  SFGTestUtils.m
//  sf-geojson-iosTests
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGTestUtils.h"
#import "SFGFeatureConverter.h"

#define ARC4RANDOM_MAX      0x100000000

@implementation SFGTestUtils

+(void) compareSFGeometry: (SFGeometry *) simpleGeometry withInput: (NSString *) input{
    SFGGeometry *geometry = [SFGFeatureConverter simpleGeometryToGeometry:simpleGeometry];
    [self compareGeometry:geometry withInput:input];
}

+(void) compareGeometry: (SFGGeometry *) geometry withInput: (NSString *) input{
    NSDictionary *treeFromGeometry = [geometry toTree];
    NSDictionary *treeFromJSON = [SFGFeatureConverter jsonToTree:input];
    NSString *json = [SFGFeatureConverter treeToJSON:treeFromJSON];
    NSObject *coordinates = [geometry coordinates];
    [self assertEqualWithValue:input andValue2:json];
    [self assertTrue:[treeFromGeometry isEqualToDictionary:treeFromJSON]];
    SFGGeoJsonObject *object = [SFGFeatureConverter treeToObject:treeFromJSON];
    
    NSNumber *number = [[treeFromJSON objectForKey:@"coordinates"] objectAtIndex:0];
    BOOL temp = [number class] == [NSDecimalNumber class];
    BOOL temp2 = [number class] == [NSNumber class];
    NSDecimalNumber *temp3 = (NSDecimalNumber *) number;
    BOOL temp4 = [temp3 class] == [NSDecimalNumber class];
    double value = [number doubleValue];
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
