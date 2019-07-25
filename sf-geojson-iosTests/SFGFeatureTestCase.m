//
//  SFGFeatureTestCase.m
//  sf-geojson-iosTests
//
//  Created by Brian Osborn on 7/23/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGFeatureTestCase.h"
#import "SFGTestUtils.h"
#import "SFGFeature.h"
#import "SFGFeatureConverter.h"

@implementation SFGFeatureTestCase

-(void) testSerializeFeature{
    
    SFGFeature *feature = [[SFGFeature alloc] init];
    
    [SFGTestUtils assertNotNil:[feature properties]];
    
    NSString *json = @"{\"type\":\"Feature\",\"geometry\":null}";
    
    [self compareFeature:feature withJSON:json];
    
}

-(void) testSerializeFeature2{

    SFGFeature *feature = [self createTestFeature];
    
    [[feature properties] setObject:@"bar" forKey:@"foo"];
    
    NSString *json = @"{\"type\":\"Feature\",\"geometry\":{\"type\":\"MultiPolygon\",\"coordinates\":[[[[-100.1,-50.3],[100,-50],[1.5,50.6],[-100.1,-50.3]],[[-50,-25],[50.7,-25.9],[-1,25],[-50,-25]]]]},\"properties\":{\"foo\":\"bar\"}}";
    
    [self compareFeature:feature withJSON:json];
}

-(void) testDeserializeFeature{
    NSString *json = @"{\"type\":\"Feature\",\"geometry\":{\"type\":\"Point\",\"coordinates\":[100.0,5.0]},\"properties\":{}}";
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:json];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGFeature class]];
    SFGFeature *feature = (SFGFeature *) object;
    SFGeometry * geometry = [feature simpleGeometry];
    [SFGTestUtils assertTrue:[geometry class] == [SFPoint class]];
    SFPoint *point = (SFPoint *) geometry;
    [SFGTestUtils assertPointWithLongitude:100 andLatitude:5 andAltitude:nil andPoint:(SFGPoint *)[SFGFeatureConverter simpleGeometryToGeometry:point]];
}

-(void) testDeserializeFeatureWithProperty{
    NSString *json = @"{\"type\":\"Feature\",\"geometry\":null,\"properties\":{\"foo\":\"bar\"}}";
    SFGGeoJSONObject *object = [SFGFeatureConverter jsonToObject:json];
    [SFGTestUtils assertNotNil:object];
    [SFGTestUtils assertTrue:[object class] == [SFGFeature class]];
    SFGFeature *feature = (SFGFeature *) object;
    [SFGTestUtils assertNil:[feature simpleGeometry]];
    NSMutableDictionary<NSString *, NSObject *> *properties = [feature properties];
    [SFGTestUtils assertEqualWithValue:@"bar" andValue2:[properties objectForKey:@"foo"]];
}

-(void) testToTree{
    
    SFGFeature *feature = [self createTestFeature];
    
    NSDictionary *tree = [SFGFeatureConverter objectToTree:feature];
    [SFGTestUtils assertNotNil:tree];
    [SFGTestUtils assertFalse:tree.count == 0];
    
    SFGFeature *featureFromTree = [SFGFeatureConverter treeToFeature:tree];
    [SFGTestUtils assertNotNil:featureFromTree];
    
    [SFGTestUtils assertTrue:[[feature simpleGeometry] isEqual:[featureFromTree simpleGeometry]]];

    SFGGeoJSONObject *objectFromJSON = [SFGFeatureConverter treeToObject:tree];
    [SFGTestUtils assertNotNil:objectFromJSON];
    [SFGTestUtils assertTrue:[objectFromJSON class] == [SFGFeature class]];

    SFGFeature *featureFromJSON = (SFGFeature *) objectFromJSON;
    [SFGTestUtils assertTrue:[[feature simpleGeometry] isEqual:[featureFromJSON simpleGeometry]]];
}

-(void) testToGeometry{
    
    SFMultiPolygon *simpleGeometry = [SFGTestUtils multiPolygonWithRings];
    
    SFGFeature *feature = [SFGFeatureConverter simpleGeometryToFeature:simpleGeometry];
    [SFGTestUtils assertNotNil:feature];
    
    [SFGTestUtils assertTrue:[simpleGeometry isEqual:[feature simpleGeometry]]];
}

-(void) testToJSON{
    
    SFGFeature *feature = [self createTestFeature];
    
    NSString *json = [SFGFeatureConverter objectToJSON:feature];
    [SFGTestUtils assertNotNil:json];
    [SFGTestUtils assertFalse:json.length == 0];
    
    SFGFeature *featureFromJSON = [SFGFeatureConverter jsonToFeature:json];
    [SFGTestUtils assertNotNil:featureFromJSON];
    
    [SFGTestUtils assertTrue:[[feature simpleGeometry] isEqual:[featureFromJSON simpleGeometry]]];
    
    SFGGeoJSONObject *objectFromJSON = [SFGFeatureConverter jsonToObject:json];
    [SFGTestUtils assertNotNil:objectFromJSON];
    [SFGTestUtils assertTrue:[objectFromJSON class] == [SFGFeature class]];

    SFGFeature *featureFromJSON2 = (SFGFeature *) objectFromJSON;
    [SFGTestUtils assertTrue:[[feature simpleGeometry] isEqual:[featureFromJSON2 simpleGeometry]]];
}

-(void) compareFeature: (SFGFeature *) feature withJSON: (NSString *) json{
    
    NSMutableDictionary *treeFromObject = [feature toTree];
    NSMutableDictionary *treeFromJSON = [SFGFeatureConverter jsonToMutableTree:json];
    NSString *jsonFromTree = [SFGFeatureConverter treeToJSON:treeFromJSON];
    if([treeFromJSON objectForKey:SFG_PROPERTIES] == nil){
        [treeFromJSON setObject:[[NSMutableDictionary alloc] init] forKey:SFG_PROPERTIES];
    }
    [SFGTestUtils assertTrue:[treeFromObject isEqualToDictionary:treeFromJSON]];
    [SFGTestUtils assertEqualWithValue:json andValue2:jsonFromTree];
    
    SFGGeoJSONObject *objectFromJSON = [SFGFeatureConverter jsonToObject:json];
    [SFGTestUtils assertTrue:[objectFromJSON class] == [SFGFeature class]];
    [SFGTestUtils assertEqualWithValue:SFG_TYPE_FEATURE andValue2:[objectFromJSON type]];
    SFGFeature *featureFromJSON = (SFGFeature *) objectFromJSON;
    
    NSString *jsonFromFeature = [SFGFeatureConverter objectToJSON:featureFromJSON];
    NSString *jsonFromModifiedTree = [SFGFeatureConverter treeToJSON:treeFromJSON];
    [SFGTestUtils assertEqualWithValue:jsonFromModifiedTree andValue2:jsonFromFeature];
    
}

-(SFGFeature *) createTestFeature{
    
    SFGeometry *geometry = [SFGTestUtils multiPolygonWithRings];
    SFGFeature *feature = [SFGFeatureConverter simpleGeometryToFeature:geometry];
    
    return feature;
}

@end
