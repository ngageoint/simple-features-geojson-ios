//
//  SFGLineString.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGLineString.h"
#import "SFGPoint.h"

@implementation SFGLineString

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

-(instancetype) initWithLineString: (SFLineString *) lineString{
    self = [super init];
    if(self != nil){
        [self setLineString:lineString];
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(enum SFGGeometryType) geometryType{
    return SFG_LINESTRING;
}

-(SFGeometry *) geometry{
    return [self lineString];
}

-(SFLineString *) lineString{
    NSMutableArray<SFPoint *> *simplePoints = [NSMutableArray array];
    for(SFGPoint *point in _points){
        [simplePoints addObject:[point point]];
    }
    return [[SFLineString alloc] initWithPoints:simplePoints];
}

-(void) setLineString: (SFLineString *) lineString{
    _points = [NSMutableArray array];
    for(SFPoint *point in lineString.points){
        [_points addObject:[[SFGPoint alloc] initWithPoint:point]];
    }
}

-(NSArray *) coordinates{
    return [SFGLineString coordinatesFromLineString:self.lineString];
}

-(void) setCoordinates: (NSArray *) coordinates{
    self.lineString = [SFGLineString lineStringFromCoordinates:coordinates];
}

+(NSMutableArray *) coordinatesFromLineString: (SFLineString *) lineString{
    NSMutableArray *coordinates = [[NSMutableArray alloc] init];
    for(SFPoint *point in lineString.points){
        [coordinates addObject:[SFGPoint coordinatesFromPoint:point]];
    }
    return coordinates;
}

+(SFLineString *) lineStringFromCoordinates: (NSArray *) coordinates{
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    for(NSArray *pointCoordinates in coordinates){
        [points addObject:[SFGPoint pointFromCoordinates:pointCoordinates]];
    }
    return [[SFLineString alloc] initWithPoints:points];
}

@end
