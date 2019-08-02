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

static NSString *FEATURECOLLECTION = @"{\"type\":\"FeatureCollection\",\"features\":[{\"type\":\"Feature\",\"geometry\":{\"type\":\"GeometryCollection\",\"geometries\":[{\"type\":\"Point\",\"coordinates\":[61.34765625,48.63290858589535]},{\"type\":\"LineString\",\"coordinates\":[[100.0,10.0],[101.0,1.0]]}]}},{\"type\":\"Feature\",\"geometry\":{\"type\":\"Point\",\"coordinates\":[50.1,60.9]}}]}";

-(void) testProperties{
    [SFGTestUtils assertNotNil:[[SFGFeatureCollection alloc] init].features];
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

@end
