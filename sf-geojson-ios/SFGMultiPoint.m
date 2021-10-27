//
//  SFGMultiPoint.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGMultiPoint.h"
#import "SFGPoint.h"

@implementation SFGMultiPoint

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super initWithCoordinates:coordinates];
    return self;
}

-(instancetype) initWithPoints: (NSArray<SFGPoint *> *) points{
    self = [super init];
    if(self != nil){
        _points = [NSMutableArray arrayWithArray:points];
    }
    return self;
}

-(instancetype) initWithMultiPoint: (SFMultiPoint *) multiPoint{
    self = [super init];
    if(self != nil){
        [self setMultiPoint:multiPoint];
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(enum SFGGeometryType) geometryType{
    return SFG_MULTIPOINT;
}

-(SFGeometry *) geometry{
    return [self multiPoint];
}

-(SFMultiPoint *) multiPoint{
    NSMutableArray<SFPoint *> *simplePoints = [NSMutableArray array];
    for(SFGPoint *point in _points){
        [simplePoints addObject:[point point]];
    }
    return [[SFMultiPoint alloc] initWithPoints:simplePoints];
}

-(void) setMultiPoint: (SFMultiPoint *) multiPoint{
    _points = [NSMutableArray array];
    for(SFPoint *point in multiPoint.points){
        [_points addObject:[[SFGPoint alloc] initWithPoint:point]];
    }
}

-(NSArray *) coordinates{
    NSMutableArray *coordinates = [NSMutableArray array];
    for(SFGPoint *point in _points){
        [coordinates addObject:[point coordinates]];
    }
    return coordinates;
}

-(void) setCoordinates: (NSArray *) coordinates{
    _points = [NSMutableArray array];
    for(NSArray *pointCoordinates in coordinates){
        [_points addObject:[[SFGPoint alloc] initWithCoordinates:pointCoordinates]];
    }
}

@end
