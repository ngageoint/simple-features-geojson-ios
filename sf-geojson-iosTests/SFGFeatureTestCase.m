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
    
    NSString *json = @"{\"type\":\"Feature\",\"properties\":{\"foo\":\"bar\"},\"geometry\":{\"type\":\"MultiPolygon\",\"coordinates\":[[[[-100.0,-50.0],[100.0,-50.0],[1.0,50.0],[-100.0,-50.0]],[[-50.0,-25.0],[50.0,-25.0],[-1.0,25.0],[-50.0,-25.0]]]]}}";
    
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
    // TODO
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
