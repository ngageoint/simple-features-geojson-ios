//
//  SFGMultiPolygon.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGMultiPolygon.h"
#import "SFGPolygon.h"

@implementation SFGMultiPolygon

+(SFGMultiPolygon *) multiPolygon{
    return [[SFGMultiPolygon alloc] init];
}

+(SFGMultiPolygon *) multiPolygonWithCoordinates: (NSArray *) coordinates{
    return [[SFGMultiPolygon alloc] initWithCoordinates:coordinates];
}

+(SFGMultiPolygon *) multiPolygonWithPolygons: (NSArray<SFGPolygon *> *) polygons{
    return [[SFGMultiPolygon alloc] initWithPolygons:polygons];
}

+(SFGMultiPolygon *) multiPolygonWithMultiPolygon: (SFMultiPolygon *) multiPolygon{
    return [[SFGMultiPolygon alloc] initWithMultiPolygon:multiPolygon];
}

+(SFGMultiPolygon *) multiPolygonWithTree: (NSDictionary *) tree{
    return [[SFGMultiPolygon alloc] initWithTree:tree];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super initWithCoordinates:coordinates];
    return self;
}

-(instancetype) initWithPolygons: (NSArray<SFGPolygon *> *) polygons{
    self = [super init];
    if(self != nil){
        _polygons = [NSMutableArray arrayWithArray:polygons];
    }
    return self;
}

-(instancetype) initWithMultiPolygon: (SFMultiPolygon *) multiPolygon{
    self = [super init];
    if(self != nil){
        [self setMultiPolygon:multiPolygon];
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(enum SFGGeometryType) geometryType{
    return SFG_MULTIPOLYGON;
}

-(SFGeometry *) geometry{
    return [self multiPolygon];
}

-(SFMultiPolygon *) multiPolygon{
    NSMutableArray<SFPolygon *> *simplePolygons = [NSMutableArray array];
    for(SFGPolygon *polygon in _polygons){
        [simplePolygons addObject:[polygon polygon]];
    }
    return [SFMultiPolygon multiPolygonWithPolygons:simplePolygons];
}

-(void) setMultiPolygon: (SFMultiPolygon *) multiPolygon{
    _polygons = [NSMutableArray array];
    for(SFPolygon *polygon in [multiPolygon polygons]){
        [_polygons addObject:[SFGPolygon polygonWithPolygon:polygon]];
    }
}

-(NSArray *) coordinates{
    NSMutableArray *coordinates = [NSMutableArray array];
    for(SFGPolygon *polygon in _polygons){
        [coordinates addObject:[polygon coordinates]];
    }
    return coordinates;
}

-(void) setCoordinates: (NSArray *) coordinates{
    _polygons = [NSMutableArray array];
    for(NSArray *polygonCoordinates in coordinates){
        [_polygons addObject:[SFGPolygon polygonWithCoordinates:polygonCoordinates]];
    }
}

@end
