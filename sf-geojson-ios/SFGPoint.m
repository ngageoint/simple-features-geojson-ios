//
//  SFGPoint.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGPoint.h"

@implementation SFGPoint

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super initWithCoordinates:coordinates];
    return self;
}

-(instancetype) initWithPosition: (SFGPosition *) position{
    self = [super init];
    if(self != nil){
        _position = position;
    }
    return self;
}

-(instancetype) initWithPoint: (SFPoint *) point{
    self = [super init];
    if(self != nil){
        [self setPoint:point];
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(enum SFGGeometryType) geometryType{
    return SFG_POINT;
}

-(SFGeometry *) geometry{
    return [self point];
}

-(SFPoint *) point{
    return [_position toSimplePoint];
}

-(void) setPoint: (SFPoint *) point{
    _position = [[SFGPosition alloc] initWithPoint:point];
}

-(NSArray *) coordinates{
    return _position.coordinates;
}

-(void) setCoordinates: (NSArray *) coordinates{
    _position = [[SFGPosition alloc] initWithCoordinates:coordinates];
}

@end
