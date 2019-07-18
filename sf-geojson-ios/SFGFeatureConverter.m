//
//  SFGFeatureConverter.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGFeatureConverter.h"
#import "SFGPoint.h"
#import "SFPoint.h"

@implementation SFGFeatureConverter

+(NSMutableDictionary *) jsonToMutableTree: (NSString *) json{
    return [[self jsonToTree:json] mutableCopy];
}

+(NSDictionary *) jsonToTree: (NSString *) json{
    
    NSDictionary *tree = nil;
    
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if(error){
        [NSException raise:@"JSON to Object" format:@"Failed to convert JSON to a JSON Object. JSON: %@, error: %@", json, error];
    }
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)jsonObject;
        tree = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNull null], array, nil];
    } else {
        tree = (NSMutableDictionary *)jsonObject;
    }
    
    return tree;
}

+(NSString *) treeToJSON: (id) object{
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:kNilOptions error:&error];
    
    if(error){
        [NSException raise:@"Object To JSON" format:@"Failed to convert a JSON Object to JSON. class: %@, error: %@", NSStringFromClass([object class]), error];
    }
    
    NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return content;
}

+(SFGGeoJsonObject *) treeToObject: (NSDictionary *) tree{
    SFGGeoJsonObject *object = nil;
    
    NSString *type = [tree objectForKey:@"type"];
    if([type isEqualToString:@"Point"]){
        object = [[SFGPoint alloc] initWithTree:tree];
    }else{
        // TODO
    }
    
    return object;
}

+(SFGGeometry *) simpleGeometryToGeometry: (SFGeometry *) simpleGeometry{
    SFGGeometry *geometry = nil;
    if(simpleGeometry != nil){
        Class simpleGeometryClass = [simpleGeometry class];
        if(simpleGeometryClass == [SFPoint class]){
            geometry = [[SFGPoint alloc] initWithPoint:(SFPoint *)simpleGeometry];
        }else{
            // TODO
        }
    }
    return geometry;
}

@end
