//
//  SFGPolygon.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGPolygon.h"
#import "SFGeometryUtils.h"
#import "SFLinearRing.h"
#import "SFGPoint.h"

@implementation SFGPolygon

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super initWithCoordinates:coordinates];
    return self;
}

-(instancetype) initWithRings: (NSArray<SFGLineString *> *) rings{
    self = [super init];
    if(self != nil){
        _rings = [NSMutableArray arrayWithArray:rings];
    }
    return self;
}

-(instancetype) initWithPolygon: (SFPolygon *) polygon{
    self = [super init];
    if(self != nil){
        [self setPolygon:polygon];
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(enum SFGGeometryType) geometryType{
    return SFG_POLYGON;
}

-(SFGeometry *) geometry{
    return [self polygon];
}

-(SFPolygon *) polygon{
    SFPolygon *polygon = [[SFPolygon alloc] init];
    for(SFGLineString *ring in _rings){
        [polygon addRing:[[SFLinearRing alloc] initWithPoints:[ring lineString].points]];
    }
    return polygon;
}

-(void) setPolygon: (SFPolygon *) polygon{
    _rings = [NSMutableArray array];
    for(SFLineString *ring in polygon.rings){
        [_rings addObject:[[SFGLineString alloc] initWithLineString:ring]];
    }
}

-(NSArray *) coordinates{
    return [SFGPolygon coordinatesFromPolygon:self.polygon];
}

-(void) setCoordinates: (NSArray *) coordinates{
    self.polygon = [SFGPolygon polygonFromCoordinates:coordinates];
}

+(NSMutableArray *) coordinatesFromPolygon: (SFPolygon *) polygon{
    NSMutableArray *coordinates = [[NSMutableArray alloc] init];
    for(SFLineString *ring in polygon.rings){
        NSMutableArray *ringCoordinates = [[NSMutableArray alloc] init];
        for(SFPoint *point in ring.points){
            [ringCoordinates addObject:[SFGPoint coordinatesFromPoint:point]];
        }
        [coordinates addObject:ringCoordinates];
    }
    return coordinates;
}

+(SFPolygon *) polygonFromCoordinates: (NSArray *) coordinates{
    NSMutableArray<SFLineString *> *rings = [[NSMutableArray alloc] init];
    for(NSArray *ringCoordinates in coordinates){
        NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
        for(NSArray *pointCoordinates in ringCoordinates){
            [points addObject:[SFGPoint pointFromCoordinates:pointCoordinates]];
        }
        SFLinearRing *ring = [[SFLinearRing alloc] initWithHasZ:[SFGeometryUtils hasZ:points] andHasM:[SFGeometryUtils hasM:points]];
        [ring setPoints:points];
        [rings addObject:ring];
    }
    return [[SFPolygon alloc] initWithRings:rings];
}

@end
