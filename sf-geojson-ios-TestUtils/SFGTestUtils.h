//
//  SFGTestUtils.h
//  sf-geojson-iosTests
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

@import SimpleFeatures;
@import SimpleFeaturesGeoJSON;

@interface SFGTestUtils : NSObject

+(void) compareSFGeometry: (SFGeometry *) simpleGeometry withInput: (NSString *) json;

+(void) compareGeometry: (SFGGeometry *) geometry withInput: (NSString *) json;

+(void) assertPointWithLongitude: (double) longitude andLatitude: (double) latitude andAltitude: (NSNumber *) altitude andPoint: (SFGPoint *) point;

+(void) assertPointWithLongitude: (double) longitude andLatitude: (double) latitude andAltitude: (NSNumber *) altitude andAdditional: (NSArray<NSNumber *> *) additionalElements andPoint: (SFGPoint *) point;

+(void) assertPositionWithLongitude: (double) longitude andLatitude: (double) latitude andAltitude: (NSNumber *) altitude andAdditional: (NSArray<NSNumber *> *) additionalElements andCoordinates: (NSArray *) coordinates;

+(void) assertPositionWithLongitude: (double) longitude andLatitude: (double) latitude andAltitude: (NSNumber *) altitude andAdditional: (NSArray<NSNumber *> *) additionalElements andPosition: (SFGPosition *) position;

+(void) assertSimplePointWithLongitude: (double) longitude andLatitude: (double) latitude andAltitude: (NSNumber *) altitude andAdditional: (NSArray<NSNumber *> *) additionalElements andSimplePoint: (SFPoint *) point;

+(SFMultiPolygon *) multiPolygonWithRings;

+(void) simpleGeometryToGeometry: (SFGeometry *) simpleGeometry;

+(void) simpleGeometryToTree: (SFGeometry *) simpleGeometry;

+(void) simpleGeometryToJSON: (SFGeometry *) simpleGeometry;

+(void)assertNil:(id) value;

+(void)assertNotNil:(id) value;

+(void)assertTrue: (BOOL) value;

+(void)assertFalse: (BOOL) value;

+(void)assertEqualWithValue:(NSObject *) value andValue2: (NSObject *) value2;

+(void)assertEqualBoolWithValue:(BOOL) value andValue2: (BOOL) value2;

+(void)assertEqualIntWithValue:(int) value andValue2: (int) value2;

+(void)assertEqualDoubleWithValue:(double) value andValue2: (double) value2;

+(void)assertEqualDoubleWithValue:(double) value andValue2: (double) value2 andDelta: (double) delta;

+(NSDecimalNumber *) roundDouble: (double) value;

+(NSDecimalNumber *) roundDouble: (double) value withScale: (int) scale;

+(int) randomIntLessThan: (int) max;

+(double) randomDouble;

+(double) randomDoubleLessThan: (double) max;

+(BOOL) coinFlip;

@end
