//
//  SFGFeatureConverter.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGFeatureConverter.h"
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

+(SFGGeoJSONObject *) treeToObject: (NSDictionary *) tree{
    SFGGeoJSONObject *object = nil;
    
    NSString *type = [SFGGeoJSONObject treeType:tree];
    
    if(false){ //TODO
        //TODO
    }else{
        object = [self treeToGeometry:tree];
    }
    
    return object;
}

+(SFGGeometry *) treeToGeometry: (NSDictionary *) tree{
    SFGGeometry *geometry = nil;
    
    NSString *type = [SFGGeoJSONObject treeType:tree];
    
    if([type isEqualToString:SFG_TYPE_POINT]){
        geometry = [self treeToPoint:tree];
    }else{
        // TODO
    }
    
    return geometry;
}

+(SFGPoint *) treeToPoint: (NSDictionary *) tree{
    return [[SFGPoint alloc] initWithTree:tree];
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
                // TODO
                break;
            case SF_MULTIPOINT:
                // TODO
                break;
            case SF_MULTILINESTRING:
                // TODO
                break;
            case SF_MULTIPOLYGON:
                // TODO
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

@end
