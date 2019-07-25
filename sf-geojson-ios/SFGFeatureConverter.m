//
//  SFGFeatureConverter.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGFeatureConverter.h"

@implementation SFGFeatureConverter

+(SFGFeature *) jsonToFeature: (NSString *) json{
    return [self treeToFeature:[self jsonToTree:json]];
}

+(SFGFeature *) treeToFeature: (NSDictionary *) tree{
    return [[SFGFeature alloc] initWithTree:tree];
}

+(SFGFeature *) simpleGeometryToFeature: (SFGeometry *) simpleGeometry{
    SFGGeometry *geometry = [self simpleGeometryToGeometry:simpleGeometry];
    SFGFeature *feature = [[SFGFeature alloc] initWithGeometry:geometry];
    return feature;
}

+(SFGGeoJSONObject *) jsonToObject: (NSString *) json{
    return [self treeToObject:[self jsonToTree:json]];
}

+(SFGGeoJSONObject *) treeToObject: (NSDictionary *) tree{
    SFGGeoJSONObject *object = nil;
    
    NSString *type = [SFGGeoJSONObject treeType:tree];
    
    if([type isEqualToString:SFG_TYPE_FEATURE]){
        object = [self treeToFeature:tree];
    }else if([type isEqualToString:SFG_TYPE_FEATURE_COLLECTION]){
        //TODO object = [self treeToFeatureCollection:tree];
    }else{
        object = [self treeToGeometry:tree];
    }
    
    return object;
}

+(NSString *) objectToJSON: (SFGGeoJSONObject *) object{
    NSDictionary *tree = [self objectToTree:object];
    NSString *json = [self treeToJSON:tree];
    return json;
}

+(NSString *) simpleGeometryToJSON: (SFGeometry *) simpleGeometry{
    SFGGeometry *geometry = [self simpleGeometryToGeometry:simpleGeometry];
    NSString *json = [self objectToJSON:geometry];
    return json;
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

+(NSMutableDictionary *) objectToMutableTree: (SFGGeoJSONObject *) object{
    return [object toTree];
}

+(NSDictionary *) objectToTree: (SFGGeoJSONObject *) object{
    return [self objectToMutableTree:object];
}

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

+(NSMutableDictionary *) simpleGeometryToMutableTree: (SFGeometry *) simpleGeometry{
    SFGGeometry *geometry = [self simpleGeometryToGeometry:simpleGeometry];
    return [geometry toTree];
}

+(NSDictionary *) simpleGeometryToTree: (SFGeometry *) simpleGeometry{
    return [self simpleGeometryToMutableTree:simpleGeometry];
}

+(SFGGeometry *) jsonToGeometry: (NSString *) json{
    return [self treeToGeometry:[self jsonToTree:json]];
}

+(SFGGeometry *) treeToGeometry: (NSDictionary *) tree{
    SFGGeometry *geometry = nil;
    
    NSString *type = [SFGGeoJSONObject treeType:tree];
    
    if([type isEqualToString:SFG_TYPE_POINT]){
        geometry = [self treeToPoint:tree];
    }else if([type isEqualToString:SFG_TYPE_POLYGON]){
        geometry = [self treeToPolygon:tree];
    }else if([type isEqualToString:SFG_TYPE_MULTI_POLYGON]){
        geometry = [self treeToMultiPolygon:tree];
    }else{
        // TODO
    }
    
    return geometry;
}

+(SFGGeometry *) simpleGeometryToGeometry: (SFGeometry *) simpleGeometry{
    SFGGeometry *geometry = nil;
    if(simpleGeometry != nil){
        enum SFGeometryType geometryType = simpleGeometry.geometryType;
        switch (geometryType) {
            case SF_POINT:
                geometry = [[SFGPoint alloc] initWithPoint:(SFPoint *)simpleGeometry];
                break;
            case SF_LINESTRING:
                // TODO
                break;
            case SF_POLYGON:
                geometry = [[SFGPolygon alloc] initWithPolygon:(SFPolygon *)simpleGeometry];
                break;
            case SF_MULTIPOINT:
                // TODO
                break;
            case SF_MULTILINESTRING:
                // TODO
                break;
            case SF_MULTIPOLYGON:
                geometry = [[SFGMultiPolygon alloc] initWithMultiPolygon:(SFMultiPolygon *)simpleGeometry];
                break;
            case SF_GEOMETRYCOLLECTION:
                // TODO
                break;
            default:
                [NSException raise:@"Unsupported" format:@"Unsupported Geometry Type: %@", [SFGeometryTypes name:geometryType]];
                break;
        }
    }
    return geometry;
}

+(SFGPoint *) treeToPoint: (NSDictionary *) tree{
    return [[SFGPoint alloc] initWithTree:tree];
}

+(SFGPolygon *) treeToPolygon: (NSDictionary *) tree{
    return [[SFGPolygon alloc] initWithTree:tree];
}

+(SFGMultiPolygon *) treeToMultiPolygon: (NSDictionary *) tree{
    return [[SFGMultiPolygon alloc] initWithTree:tree];
}

@end
