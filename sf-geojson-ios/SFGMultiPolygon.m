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
    return [[SFMultiPolygon alloc] initWithPolygons:simplePolygons];
}

-(void) setMultiPolygon: (SFMultiPolygon *) multiPolygon{
    _polygons = [NSMutableArray array];
    for(SFPolygon *polygon in [multiPolygon polygons]){
        [_polygons addObject:[[SFGPolygon alloc] initWithPolygon:polygon]];
    }
}

-(NSArray *) coordinates{
    return [SFGMultiPolygon coordinatesFromMultiPolygon:self.multiPolygon];
}

-(void) setCoordinates: (NSArray *) coordinates{
    self.multiPolygon = [SFGMultiPolygon multiPolygonFromCoordinates:coordinates];
}

+(NSMutableArray *) coordinatesFromMultiPolygon: (SFMultiPolygon *) multiPolygon{
    NSMutableArray *coordinates = [[NSMutableArray alloc] init];
    for(SFPolygon *polygon in multiPolygon.geometries){
        [coordinates addObject:[SFGPolygon coordinatesFromPolygon:polygon]];
    }
    return coordinates;
}

+(SFMultiPolygon *) multiPolygonFromCoordinates: (NSArray *) coordinates{
    NSMutableArray<SFPolygon *> *polygons = [[NSMutableArray alloc] init];
    for(NSArray *polygonCoordinates in coordinates){
        SFPolygon *polygon = [SFGPolygon polygonFromCoordinates:polygonCoordinates];
        [polygons addObject:polygon];
    }
    return [[SFMultiPolygon alloc] initWithPolygons:polygons];
}

@end
