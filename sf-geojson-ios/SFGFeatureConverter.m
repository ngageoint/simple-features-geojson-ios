//
//  SFGFeatureConverter.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import <SimpleFeaturesGeoJSON/SFGFeatureConverter.h>
@import SimpleFeatures;

@implementation SFGFeatureConverter

+(SFGFeature *) jsonToFeature: (NSString *) json{
    return [self treeToFeature:[self jsonToTree:json]];
}

+(SFGFeature *) treeToFeature: (NSDictionary *) tree{
    return [SFGFeature featureWithTree:tree];
}

+(SFGFeature *) simpleGeometryToFeature: (SFGeometry *) simpleGeometry{
    SFGGeometry *geometry = [self simpleGeometryToGeometry:simpleGeometry];
    SFGFeature *feature = [SFGFeature featureWithGeometry:geometry];
    return feature;
}

+(SFGFeatureCollection *) jsonToFeatureCollection: (NSString *) json{
    return [self treeToFeatureCollection:[self jsonToTree:json]];
}

+(SFGFeatureCollection *) treeToFeatureCollection: (NSDictionary *) tree{
    return [SFGFeatureCollection featureCollectionWithTree:tree];
}

+(SFGFeatureCollection *) simpleGeometryToFeatureCollection: (SFGeometry *) simpleGeometry{
    SFGFeature *feature = [self simpleGeometryToFeature:simpleGeometry];
    SFGFeatureCollection *featureCollection = [SFGFeatureCollection featureCollectionWithFeature:feature];
    return featureCollection;
}

+(SFGFeatureCollection *) simpleGeometriesToFeatureCollection: (NSArray<SFGeometry *> *) simpleGeometries{
    NSMutableArray<SFGFeature *> *features = [NSMutableArray array];
    for(SFGeometry *simpleGeometry in simpleGeometries){
        SFGFeature *feature = [self simpleGeometryToFeature:simpleGeometry];
        [features addObject:feature];
    }
    SFGFeatureCollection *featureCollection = [SFGFeatureCollection featureCollectionWithFeatures:features];
    return featureCollection;
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
        object = [self treeToFeatureCollection:tree];
    }else{
        object = [self treeToGeometry:tree];
    }
    
    return object;
}

+(SFGeometry *) jsonToSimpleGeometry: (NSString *) json{
    return [self objectToSimpleGeometry:[self jsonToObject:json]];
}

+(SFGeometry *) treeToSimpleGeometry: (NSDictionary *) tree{
    return [self objectToSimpleGeometry:[self treeToObject:tree]];
}

+(SFGeometry *) objectToSimpleGeometry: (SFGGeoJSONObject *) geoJson{
    SFGeometry *geometry = nil;
    if(geoJson != nil){
        geometry = [geoJson simpleGeometry];
    }
    return geometry;
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
    content = [content stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    
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
        tree = [NSDictionary dictionaryWithObjectsAndKeys:[NSNull null], array, nil];
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
    
    SFGGeometryTypes *geometryType = [SFGGeometryTypes fromName:type];
    
    if(geometryType == nil){
        [NSException raise:@"Unsupported" format:@"Unsupported Geometry Type: %@", type];
    }
    
    switch([geometryType type]){
        case SFG_POINT:
            geometry = [self treeToPoint:tree];
            break;
        case SFG_LINESTRING:
            geometry = [self treeToLineString:tree];
            break;
        case SFG_POLYGON:
            geometry = [self treeToPolygon:tree];
            break;
        case SFG_MULTIPOINT:
            geometry = [self treeToMultiPoint:tree];
            break;
        case SFG_MULTILINESTRING:
            geometry = [self treeToMultiLineString:tree];
            break;
        case SFG_MULTIPOLYGON:
            geometry = [self treeToMultiPolygon:tree];
            break;
        case SFG_GEOMETRYCOLLECTION:
            geometry = [self treeToGeometryCollection:tree];
            break;
        default:
            [NSException raise:@"Unsupported" format:@"Unsupported Geometry Type: %@", type];
    }
    
    return geometry;
}

+(SFGGeometry *) simpleGeometryToGeometry: (SFGeometry *) simpleGeometry{
    SFGGeometry *geometry = nil;
    if(simpleGeometry != nil){
        SFGeometryType geometryType = simpleGeometry.geometryType;
        switch (geometryType) {
            case SF_POINT:
                geometry = [SFGPoint pointWithPoint:(SFPoint *)simpleGeometry];
                break;
            case SF_LINESTRING:
                geometry = [SFGLineString lineStringWithLineString:(SFLineString *)simpleGeometry];
                break;
            case SF_POLYGON:
                geometry = [SFGPolygon polygonWithPolygon:(SFPolygon *)simpleGeometry];
                break;
            case SF_MULTIPOINT:
                geometry = [SFGMultiPoint multiPointWithMultiPoint:(SFMultiPoint *)simpleGeometry];
                break;
            case SF_MULTILINESTRING:
                geometry = [SFGMultiLineString multiLineStringWithMultiLineString:(SFMultiLineString *)simpleGeometry];
                break;
            case SF_MULTIPOLYGON:
                geometry = [SFGMultiPolygon multiPolygonWithMultiPolygon:(SFMultiPolygon *)simpleGeometry];
                break;
            case SF_GEOMETRYCOLLECTION:
                geometry = [SFGGeometryCollection geometryCollectionWithGeometryCollection:(SFGeometryCollection *)simpleGeometry];
                break;
            default:
                [NSException raise:@"Unsupported" format:@"Unsupported Geometry Type: %@", [SFGeometryTypes name:geometryType]];
                break;
        }
    }
    return geometry;
}

+(SFGPoint *) treeToPoint: (NSDictionary *) tree{
    return [SFGPoint pointWithTree:tree];
}

+(SFGLineString *) treeToLineString: (NSDictionary *) tree{
    return [SFGLineString lineStringWithTree:tree];
}

+(SFGPolygon *) treeToPolygon: (NSDictionary *) tree{
    return [SFGPolygon polygonWithTree:tree];
}

+(SFGMultiPoint *) treeToMultiPoint: (NSDictionary *) tree{
    return [SFGMultiPoint multiPointWithTree:tree];
}

+(SFGMultiLineString *) treeToMultiLineString: (NSDictionary *) tree{
    return [SFGMultiLineString multiLineStringWithTree:tree];
}

+(SFGMultiPolygon *) treeToMultiPolygon: (NSDictionary *) tree{
    return [SFGMultiPolygon multiPolygonWithTree:tree];
}

+(SFGGeometryCollection *) treeToGeometryCollection: (NSDictionary *) tree{
    return [SFGGeometryCollection geometryCollectionWithTree:tree];
}

@end
