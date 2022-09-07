//
//  SFGFeatureCollectionTestCase.m
//  sf-geojson-iosTests
//
//  Created by Brian Osborn on 8/2/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGFeatureCollectionTestCase.h"
#import "SFGTestUtils.h"
#import "SFGFeatureCollection.h"
#import "SFGFeatureConverter.h"

@implementation SFGFeatureCollectionTestCase

static NSString *FEATURECOLLECTION = @"{\"type\":\"FeatureCollection\",\"features\":[{\"type\":\"Feature\",\"geometry\":{\"type\":\"GeometryCollection\",\"geometries\":[{\"type\":\"Point\",\"coordinates\":[61.3476,48.632908]},{\"type\":\"LineString\",\"coordinates\":[[100,10],[101.3,1]]}]},\"properties\":{}},{\"type\":\"Feature\",\"geometry\":{\"type\":\"Point\",\"coordinates\":[50,60]},\"properties\":{}}]}";

-(void) testProperties{
    [SFGTestUtils assertNotNil:[SFGFeatureCollection featureCollection].features];
}

-(void) testDeserializeFeatureCollection{
    NSString *json = @"{\"type\":\"FeatureCollection\",\"features\":[{\"type\":\"Feature\",\"geometry\":{\"type\":\"Point\",\"coordinates\":[100,5]},\"properties\":{}}]}";
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:json];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGFeatureCollection class]];
    SFGFeatureCollection *featureCollection = (SFGFeatureCollection *) object;
    [SFGTestUtils assertNotNil:featureCollection.features];
    NSArray<SFGFeature *> *features = featureCollection.features;
    [SFGTestUtils assertEqualIntWithValue:1 andValue2:(int)features.count];
    [self compareFeatureCollection:featureCollection withJSON:json];
}

-(void) testDeserializeFeatureCollection2{
    
    NSString *filePath  = [[[NSBundle bundleForClass:[SFGFeatureCollectionTestCase class]] resourcePath] stringByAppendingPathComponent:@"fc-points.geojson"];
    NSString *json = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    SFGGeoJSONObject *objectFromJSON = [SFGFeatureConverter jsonToObject:json];
    [SFGTestUtils assertTrue:[objectFromJSON class] == [SFGFeatureCollection class]];
    [SFGTestUtils assertEqualWithValue:SFG_TYPE_FEATURE_COLLECTION andValue2:[objectFromJSON type]];
    SFGFeatureCollection *featureCollectionFromJSON = (SFGFeatureCollection *) objectFromJSON;
    [SFGTestUtils assertEqualIntWithValue:6 andValue2:(int)featureCollectionFromJSON.features.count];
    for(SFGFeature *feature in featureCollectionFromJSON.features){
        [SFGTestUtils assertEqualWithValue:SFG_TYPE_FEATURE andValue2:[feature type]];
        SFGGeometry *geometryObject = [feature geometry];
        [SFGTestUtils assertEqualWithValue:[SFGGeometryTypes name:SFG_POINT] andValue2:[geometryObject type]];
        [SFGTestUtils assertEqualIntWithValue:2 andValue2:(int)[geometryObject coordinates].count];
        [SFGTestUtils assertTrue:[geometryObject class] == [SFGPoint class]];
        SFGPoint *pointObject = (SFGPoint *) geometryObject;
        SFPoint *point = [pointObject point];
        SFGeometry *geometry = [feature simpleGeometry];
        [SFGTestUtils assertTrue:[geometry class] == [SFPoint class]];
        SFPoint *point2 = (SFPoint *) geometry;
        [SFGTestUtils assertEqualWithValue:point andValue2:point2];
        [SFGTestUtils assertEqualIntWithValue:2 andValue2:(int)[feature properties].count];
    }
    
}

-(void) testDeserializeFeatureCollection3{
    
    NSString *filePath  = [[[NSBundle bundleForClass:[SFGFeatureCollectionTestCase class]] resourcePath] stringByAppendingPathComponent:@"fc-points-altitude.geojson"];
    NSString *json = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    SFGGeoJSONObject *objectFromJSON = [SFGFeatureConverter jsonToObject:json];
    [SFGTestUtils assertTrue:[objectFromJSON class] == [SFGFeatureCollection class]];
    [SFGTestUtils assertEqualWithValue:SFG_TYPE_FEATURE_COLLECTION andValue2:[objectFromJSON type]];
    SFGFeatureCollection *featureCollectionFromJSON = (SFGFeatureCollection *) objectFromJSON;
    [SFGTestUtils assertEqualIntWithValue:2 andValue2:(int)featureCollectionFromJSON.features.count];
    
    SFGFeature *feature = [featureCollectionFromJSON.features objectAtIndex:0];
    [SFGTestUtils assertEqualWithValue:SFG_TYPE_FEATURE andValue2:[feature type]];
    SFGGeometry *geometryObject = [feature geometry];
    [SFGTestUtils assertEqualWithValue:[SFGGeometryTypes name:SFG_POINT] andValue2:[geometryObject type]];
    [SFGTestUtils assertEqualIntWithValue:3 andValue2:(int)[geometryObject coordinates].count];
    [SFGTestUtils assertTrue:[geometryObject class] == [SFGPoint class]];
    SFGPoint *pointObject = (SFGPoint *) geometryObject;
    SFPoint *point = [pointObject point];
    SFGeometry *geometry = [feature simpleGeometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFPoint class]];
    SFPoint *point2 = (SFPoint *) geometry;
    [SFGTestUtils assertEqualWithValue:point andValue2:point2];
    [SFGTestUtils assertEqualIntWithValue:1 andValue2:(int)[feature properties].count];
    
    feature = [featureCollectionFromJSON.features objectAtIndex:1];
    [SFGTestUtils assertEqualWithValue:SFG_TYPE_FEATURE andValue2:[feature type]];
    geometryObject = [feature geometry];
    [SFGTestUtils assertEqualWithValue:[SFGGeometryTypes name:SFG_LINESTRING] andValue2:[geometryObject type]];
    [SFGTestUtils assertEqualIntWithValue:3 andValue2:(int)[geometryObject coordinates].count];
    for(NSArray *coordinates in [geometryObject coordinates]){
        [SFGTestUtils assertEqualIntWithValue:4 andValue2:(int)coordinates.count];
    }
    [SFGTestUtils assertTrue:[geometryObject class] == [SFGLineString class]];
    SFGLineString *lineStringObject = (SFGLineString *) geometryObject;
    SFLineString *lineString = [lineStringObject lineString];
    geometry = [feature simpleGeometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFLineString class]];
    SFLineString *lineString2 = (SFLineString *) geometry;
    [SFGTestUtils assertEqualWithValue:lineString andValue2:lineString2];
    [SFGTestUtils assertEqualIntWithValue:1 andValue2:(int)[feature properties].count];
    
}

-(void) testDeserializeFeatureCollection4{
    
    NSString *filePath  = [[[NSBundle bundleForClass:[SFGFeatureCollectionTestCase class]] resourcePath] stringByAppendingPathComponent:@"gc.geojson"];
    NSString *json = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    SFGGeoJSONObject *objectFromJSON = [SFGFeatureConverter jsonToObject:json];
    [SFGTestUtils assertTrue:[objectFromJSON class] == [SFGFeatureCollection class]];
    [SFGTestUtils assertEqualWithValue:SFG_TYPE_FEATURE_COLLECTION andValue2:[objectFromJSON type]];
    SFGFeatureCollection *featureCollectionFromJSON = (SFGFeatureCollection *) objectFromJSON;
    [SFGTestUtils assertEqualIntWithValue:1 andValue2:(int)featureCollectionFromJSON.features.count];
    
    SFGFeature *feature = [featureCollectionFromJSON.features objectAtIndex:0];
    [SFGTestUtils assertEqualWithValue:SFG_TYPE_FEATURE andValue2:[feature type]];
    SFGGeometry *geometryObject = [feature geometry];
    [SFGTestUtils assertEqualWithValue:[SFGGeometryTypes name:SFG_GEOMETRYCOLLECTION] andValue2:[geometryObject type]];
    [SFGTestUtils assertTrue:[geometryObject class] == [SFGGeometryCollection class]];
    SFGGeometryCollection *geometryCollectionObject = (SFGGeometryCollection *) geometryObject;
    SFGeometryCollection *geometryCollection = [geometryCollectionObject geometryCollection];
    SFGeometry *geometry = [feature simpleGeometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFGeometryCollection class]];
    SFGeometryCollection *geometryCollection2 = (SFGeometryCollection *) geometry;
    [SFGTestUtils assertEqualWithValue:geometryCollection andValue2:geometryCollection2];
    [SFGTestUtils assertEqualIntWithValue:0 andValue2:(int)[feature properties].count];
    
    NSArray<SFGeometry *> *geometries= geometryCollection.geometries;
    [SFGTestUtils assertEqualIntWithValue:2 andValue2:(int)geometries.count];
    
    geometry = [geometries objectAtIndex:0];
    [SFGTestUtils assertTrue:[geometry class] == [SFPoint class]];
    
    geometry = [geometries objectAtIndex:1];
    [SFGTestUtils assertTrue:[geometry class] == [SFPolygon class]];
    SFPolygon *polygon = (SFPolygon *) geometry;
    [SFGTestUtils assertEqualIntWithValue:1 andValue2:[polygon numRings]];
    [SFGTestUtils assertEqualIntWithValue:20 andValue2:[[polygon ringAtIndex:0] numPoints]];
    
}

-(void) testDeserializeFeatureCollection5{
    
    NSString *filePath  = [[[NSBundle bundleForClass:[SFGFeatureCollectionTestCase class]] resourcePath] stringByAppendingPathComponent:@"gc-multiple.geojson"];
    NSString *json = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    SFGGeoJSONObject *objectFromJSON = [SFGFeatureConverter jsonToObject:json];
    [SFGTestUtils assertTrue:[objectFromJSON class] == [SFGFeatureCollection class]];
    [SFGTestUtils assertEqualWithValue:SFG_TYPE_FEATURE_COLLECTION andValue2:[objectFromJSON type]];
    SFGFeatureCollection *featureCollectionFromJSON = (SFGFeatureCollection *) objectFromJSON;
    [SFGTestUtils assertEqualIntWithValue:7 andValue2:(int)featureCollectionFromJSON.features.count];
    
    SFGFeature *feature = [featureCollectionFromJSON.features objectAtIndex:0];
    [SFGTestUtils assertEqualWithValue:SFG_TYPE_FEATURE andValue2:[feature type]];
    SFGGeometry *geometryObject = [feature geometry];
    [SFGTestUtils assertEqualWithValue:[SFGGeometryTypes name:SFG_GEOMETRYCOLLECTION] andValue2:[geometryObject type]];
    [SFGTestUtils assertTrue:[geometryObject class] == [SFGGeometryCollection class]];
    SFGGeometryCollection *geometryCollectionObject = (SFGGeometryCollection *) geometryObject;
    SFGeometryCollection *geometryCollection = [geometryCollectionObject geometryCollection];
    SFGeometry *geometry = [feature simpleGeometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFGeometryCollection class]];
    SFGeometryCollection *geometryCollection2 = (SFGeometryCollection *) geometry;
    [SFGTestUtils assertEqualWithValue:geometryCollection andValue2:geometryCollection2];
    [SFGTestUtils assertEqualIntWithValue:0 andValue2:(int)[feature properties].count];
    
    NSArray<SFGeometry *> *geometries= geometryCollection.geometries;
    [SFGTestUtils assertEqualIntWithValue:2 andValue2:(int)geometries.count];
    
    geometry = [geometries objectAtIndex:0];
    [SFGTestUtils assertTrue:[geometry class] == [SFPoint class]];
    
    geometry = [geometries objectAtIndex:1];
    [SFGTestUtils assertTrue:[geometry class] == [SFPolygon class]];
    SFPolygon *polygon = (SFPolygon *) geometry;
    [SFGTestUtils assertEqualIntWithValue:1 andValue2:[polygon numRings]];
    [SFGTestUtils assertEqualIntWithValue:20 andValue2:[[polygon ringAtIndex:0] numPoints]];
    
    for(int i = 1; i < [featureCollectionFromJSON numFeatures]; i++){
        SFGFeature *feature = [featureCollectionFromJSON featureAtIndex:i];
        [SFGTestUtils assertEqualWithValue:SFG_TYPE_FEATURE andValue2:[feature type]];
        SFGGeometry *geometryObject = [feature geometry];
        [SFGTestUtils assertEqualWithValue:[SFGGeometryTypes name:SFG_POINT] andValue2:[geometryObject type]];
        [SFGTestUtils assertEqualIntWithValue:2 andValue2:(int)[geometryObject coordinates].count];
        [SFGTestUtils assertTrue:[geometryObject class] == [SFGPoint class]];
        SFGPoint *pointObject = (SFGPoint *) geometryObject;
        SFPoint *point = [pointObject point];
        SFGeometry *geometry = [feature simpleGeometry];
        [SFGTestUtils assertTrue:[geometry class] == [SFPoint class]];
        SFPoint *point2 = (SFPoint *) geometry;
        [SFGTestUtils assertEqualWithValue:point andValue2:point2];
        [SFGTestUtils assertEqualIntWithValue:2 andValue2:(int)[feature properties].count];
    }
    
}

-(void) testDeserializeFeatureCollection6{
    NSString *json = @"{\"type\":\"FeatureCollection\",\"bbox\":[-10.1,-10.1,10.4,10.4],\"features\":[{\"type\":\"Feature\",\"geometry\":{\"type\":\"Point\",\"coordinates\":[100.5,5.5]},\"properties\":{}}]}";
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:json];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGFeatureCollection class]];
    SFGFeatureCollection *fc = (SFGFeatureCollection *) object;
    [SFGTestUtils assertNotNil:fc.features];
    NSArray<SFGFeature *> *features = fc.features;
    [SFGTestUtils assertEqualIntWithValue:1 andValue2:(int)features.count];
    [self compareFeatureCollection:fc withJSON:json];
}

-(void) testSerializeFeatureCollection{
    SFGFeatureCollection *featureCollection = [self createTestFeatureCollection];
    [self compareFeatureCollection:featureCollection withJSON:FEATURECOLLECTION];
}

-(void) testToTree{
    
    SFGFeatureCollection *featureCollection = [self createTestFeatureCollection];
    
    NSDictionary *tree = [SFGFeatureConverter objectToTree:featureCollection];
    [SFGTestUtils assertNotNil:tree];
    [SFGTestUtils assertFalse:tree.count == 0];
    
    SFGFeatureCollection *featureCollectionFromTree = [SFGFeatureConverter treeToFeatureCollection:tree];
    [SFGTestUtils assertNotNil:featureCollectionFromTree];
    
    [SFGTestUtils assertEqualIntWithValue:[featureCollection numFeatures] andValue2:[featureCollectionFromTree numFeatures]];
    [SFGTestUtils assertEqualIntWithValue:2 andValue2:[featureCollectionFromTree numFeatures]];
    for(int i = 0; i < [featureCollection numFeatures]; i++){
        [SFGTestUtils assertEqualWithValue:[[featureCollection featureAtIndex:i] simpleGeometry] andValue2:[[featureCollectionFromTree featureAtIndex:i] simpleGeometry]];
    }
    
    SFGGeoJSONObject *objectFromTree = [SFGFeatureConverter treeToObject:tree];
    [SFGTestUtils assertNotNil:objectFromTree];
    [SFGTestUtils assertTrue:[objectFromTree class] == [SFGFeatureCollection class]];
    
    SFGFeatureCollection *featureCollectionObject = (SFGFeatureCollection *) objectFromTree;
    [SFGTestUtils assertEqualIntWithValue:[featureCollection numFeatures] andValue2:[featureCollectionObject numFeatures]];
    [SFGTestUtils assertEqualIntWithValue:2 andValue2:[featureCollectionObject numFeatures]];
    for(int i = 0; i < [featureCollection numFeatures]; i++){
        [SFGTestUtils assertEqualWithValue:[[featureCollection featureAtIndex:i] simpleGeometry] andValue2:[[featureCollectionObject featureAtIndex:i] simpleGeometry]];
    }

}

-(void) testToGeometry{
    
    NSArray<SFGeometry *> *simpleGeometries = [self createTestSimpleGeometries];
    
    SFGFeatureCollection *featureCollection = [SFGFeatureConverter simpleGeometriesToFeatureCollection:simpleGeometries];
    [SFGTestUtils assertNotNil:featureCollection];
    
    for(int i = 0; i < simpleGeometries.count; i++){
        [SFGTestUtils assertEqualWithValue:[simpleGeometries objectAtIndex:i] andValue2:[[featureCollection featureAtIndex:i] simpleGeometry]];
    }
    
}

-(void) testToJSON{
    
    SFGFeatureCollection *featureCollection = [self createTestFeatureCollection];
    
    NSString *json = [SFGFeatureConverter objectToJSON:featureCollection];
    [SFGTestUtils assertNotNil:json];
    [SFGTestUtils assertFalse:json.length == 0];
    
    SFGFeatureCollection *featureCollectionFromJSON = [SFGFeatureConverter jsonToFeatureCollection:json];
    [SFGTestUtils assertNotNil:featureCollectionFromJSON];
    
    [SFGTestUtils assertEqualIntWithValue:[featureCollection numFeatures] andValue2:[featureCollectionFromJSON numFeatures]];
    [SFGTestUtils assertEqualIntWithValue:2 andValue2:[featureCollectionFromJSON numFeatures]];
    for(int i = 0; i < [featureCollection numFeatures]; i++){
        [SFGTestUtils assertEqualWithValue:[[featureCollection featureAtIndex:i] simpleGeometry] andValue2:[[featureCollectionFromJSON featureAtIndex:i] simpleGeometry]];
    }
    
    SFGGeoJSONObject *objectFromJSON = [SFGFeatureConverter jsonToObject:json];
    [SFGTestUtils assertNotNil:objectFromJSON];
    [SFGTestUtils assertTrue:[objectFromJSON class] == [SFGFeatureCollection class]];
    
    SFGFeatureCollection *featureCollectionObject = (SFGFeatureCollection *) objectFromJSON;
    [SFGTestUtils assertEqualIntWithValue:[featureCollection numFeatures] andValue2:[featureCollectionObject numFeatures]];
    [SFGTestUtils assertEqualIntWithValue:2 andValue2:[featureCollectionObject numFeatures]];
    for(int i = 0; i < [featureCollection numFeatures]; i++){
        [SFGTestUtils assertEqualWithValue:[[featureCollection featureAtIndex:i] simpleGeometry] andValue2:[[featureCollectionObject featureAtIndex:i] simpleGeometry]];
    }

}

-(void) testAdditionalAttributes{
    
    NSArray<NSDecimalNumber *> *position = [NSArray arrayWithObjects:[[NSDecimalNumber alloc] initWithDouble:100.2], [[NSDecimalNumber alloc] initWithDouble:0.0], [[NSDecimalNumber alloc] initWithDouble:256.0], [[NSDecimalNumber alloc] initWithDouble:345], [[NSDecimalNumber alloc] initWithDouble:678], [[NSDecimalNumber alloc] initWithDouble:50.4], nil];
    NSArray *pointArray = [NSArray arrayWithObject:position];
    SFGLineString *line = [SFGLineString lineStringWithCoordinates:pointArray];
    
    SFGFeature *lineFeature = [SFGFeature featureWithGeometry:line];
    SFGFeatureCollection *featureCollection = [SFGFeatureCollection featureCollectionWithFeature:lineFeature];
    
    NSString *value = [SFGFeatureConverter objectToJSON:featureCollection];
    
    [SFGTestUtils assertEqualWithValue:@"{\"type\":\"FeatureCollection\",\"features\":[{\"type\":\"Feature\",\"geometry\":{\"type\":\"LineString\",\"coordinates\":[[100.2,0,256,345,678,50.4]]},\"properties\":{}}]}" andValue2:value];
    
}

-(void) compareFeatureCollection: (SFGFeatureCollection *) featureCollection withJSON: (NSString *) json{
    
    NSMutableDictionary *treeFromObject = [featureCollection toTree];
    NSMutableDictionary *treeFromJSON = [SFGFeatureConverter jsonToMutableTree:json];
    NSString *jsonFromTree = [SFGFeatureConverter treeToJSON:treeFromJSON];
    [SFGTestUtils assertTrue:[treeFromObject isEqualToDictionary:treeFromJSON]];
    [SFGTestUtils assertEqualWithValue:json andValue2:jsonFromTree];
    
    SFGGeoJSONObject *objectFromJSON = [SFGFeatureConverter jsonToObject:json];
    [SFGTestUtils assertTrue:[objectFromJSON class] == [SFGFeatureCollection class]];
    [SFGTestUtils assertEqualWithValue:SFG_TYPE_FEATURE_COLLECTION andValue2:[objectFromJSON type]];
    SFGFeatureCollection *featureCollectionFromJSON = (SFGFeatureCollection *) objectFromJSON;
    
    NSString *jsonFromFeatureCollection = [SFGFeatureConverter objectToJSON:featureCollectionFromJSON];
    NSString *jsonFromModifiedTree = [SFGFeatureConverter treeToJSON:treeFromJSON];
    [SFGTestUtils assertEqualWithValue:jsonFromModifiedTree andValue2:jsonFromFeatureCollection];
    
}

-(SFGFeatureCollection *) createTestFeatureCollection{
    
    NSArray<SFGeometry *> *simpleGeometries = [self createTestSimpleGeometries];
    
    SFGFeatureCollection *featureCollection = [SFGFeatureConverter simpleGeometriesToFeatureCollection:simpleGeometries];
    
    return featureCollection;
}

-(NSArray<SFGeometry *> *) createTestSimpleGeometries{
    
    NSMutableArray<SFGeometry *> *simpleGeometries = [NSMutableArray array];
    
    SFGeometryCollection *geometryCollection = [SFGeometryCollection geometryCollection];
    [geometryCollection addGeometry:[SFPoint pointWithXValue:61.3476 andYValue:48.632908]];
    SFLineString *lineString = [SFLineString lineString];
    [lineString addPoint:[SFPoint pointWithXValue:100 andYValue:10]];
    [lineString addPoint:[SFPoint pointWithXValue:101.3 andYValue:1]];
    [geometryCollection addGeometry:lineString];
    
    [simpleGeometries addObject:geometryCollection];
    
    SFPoint *point = [SFPoint pointWithXValue:50 andYValue:60];
    [simpleGeometries addObject:point];
    
    return simpleGeometries;
}

@end
