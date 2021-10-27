//
//  SFGGeometryTypes.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 10/26/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "SFGGeometryTypes.h"

@interface SFGGeometryTypes()

@property (nonatomic) enum SFGGeometryType type;
@property (nonatomic) enum SFGeometryType simpleType;
@property (nonatomic, strong) NSString *name;

@end

@implementation SFGGeometryTypes

/**
 * Type to geometry types mapping
 */
static NSMutableDictionary<NSNumber *, SFGGeometryTypes *> *types = nil;

/**
 * Name to geometry types mapping
 */
static NSMutableDictionary<NSString *, SFGGeometryTypes *> *nameTypes = nil;

+(void) initialize{
    types = [NSMutableDictionary dictionary];
    nameTypes = [NSMutableDictionary dictionary];

    [self initialize:[SFGGeometryTypes createWithType:SFG_GEOMETRY andSimpleType:SF_GEOMETRY andName:@"Geometry"]];
    [self initialize:[SFGGeometryTypes createWithType:SFG_POINT andSimpleType:SF_POINT andName:@"Point"]];
    [self initialize:[SFGGeometryTypes createWithType:SFG_LINESTRING andSimpleType:SF_LINESTRING andName:@"LineString"]];
    [self initialize:[SFGGeometryTypes createWithType:SFG_POLYGON andSimpleType:SF_POLYGON andName:@"Polygon"]];
    [self initialize:[SFGGeometryTypes createWithType:SFG_MULTIPOINT andSimpleType:SF_MULTIPOINT andName:@"MultiPoint"]];
    [self initialize:[SFGGeometryTypes createWithType:SFG_MULTILINESTRING andSimpleType:SF_MULTILINESTRING andName:@"MultiLineString"]];
    [self initialize:[SFGGeometryTypes createWithType:SFG_MULTIPOLYGON andSimpleType:SF_MULTIPOLYGON andName:@"MultiPolygon"]];
    [self initialize:[SFGGeometryTypes createWithType:SFG_GEOMETRYCOLLECTION andSimpleType:SF_GEOMETRYCOLLECTION andName:@"GeometryCollection"]];
}

+(void) initialize: (SFGGeometryTypes *) type{
    [types setObject:type forKey:[NSNumber numberWithInteger:type.type]];
    [nameTypes setObject:type forKey:[type.name lowercaseString]];
}

+(SFGGeometryTypes *) createWithType: (enum SFGGeometryType) type andSimpleType: (enum SFGeometryType) simpleType andName: (NSString *) name{
    return [[SFGGeometryTypes alloc] initWithType:type andSimpleType:simpleType andName:name];
}

-(instancetype) initWithType: (enum SFGGeometryType) type andSimpleType: (enum SFGeometryType) simpleType andName: (NSString *) name{
    self = [super init];
    if(self != nil){
        _type = type;
        _simpleType = simpleType;
        _name = name;
    }
    return self;
}

-(enum SFGGeometryType) type{
    return _type;
}

-(enum SFGeometryType) simpleType{
    return _simpleType;
}

-(NSString *) name{
    return _name;
}

+(SFGGeometryTypes *) type: (enum SFGGeometryType) geometryType{
    return [types objectForKey:[NSNumber numberWithInteger:geometryType]];
}

+(NSString *) name: (enum SFGGeometryType) geometryType{
    return [self type:geometryType].name;
}

+(SFGGeometryTypes *) fromName: (NSString *) name{
    return [nameTypes objectForKey:[name lowercaseString]];
}

@end
