//
//  SFGPoint.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGPoint.h"

NSString * const SFG_TYPE_POINT = @"Point";

@interface SFGPoint()

/**
 *  Simple point
 */
@property (nonatomic, strong) SFPoint *point;

@end

@implementation SFGPoint

-(instancetype) init{
    return [self initWithPoint:[[SFPoint alloc] init]];
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super initWithCoordinates:coordinates];
    return self;
}

-(instancetype) initWithPosition: (SFGPosition *) position{
    self = [super init];
    if(self != nil){
        [self setPosition:position];
    }
    return self;
}

-(instancetype) initWithPoint: (SFPoint *) point{
    self = [super init];
    if(self != nil){
        _point = point;
        _position = [SFGPoint positionFromPoint:point];
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(SFPoint *) point{
    return _point;
}

-(NSArray *) coordinates{
    return [SFGPoint coordinatesFromPosition:_position];
}

-(void) setCoordinates: (NSArray *) coordinates{
    [self setPosition:[SFGPoint positionFromCoordinates:coordinates]];
}

-(void) setPosition: (SFGPosition *) position{
    _point = [SFGPoint pointFromPosition:position];
    _position = position;
}

-(SFGeometry *) geometry{
    return [self point];
}

-(NSString *) type{
    return SFG_TYPE_POINT;
}

+(NSArray *) coordinatesFromPoint: (SFPoint *) point{
    SFGPosition *position = [self positionFromPoint:point];
    return [self coordinatesFromPosition:position];
}

+(NSArray *) coordinatesFromPosition: (SFGPosition *) position{
    return [position coordinates];
}

+(SFPoint *) pointFromCoordinates: (NSArray *) coordinates{
    SFGPosition *position = [self positionFromCoordinates:coordinates];
    return [self pointFromPosition:position];
}

+(SFPoint *) pointFromPosition: (SFGPosition *) position{
    return [position toSimplePoint];
}

+(SFGPosition *) positionFromCoordinates: (NSArray *) coordinates{
    return [[SFGPosition alloc] initWithCoordinates:coordinates];
}

+(SFGPosition *) positionFromPoint: (SFPoint *) point{
    return [[SFGPosition alloc] initWithPoint:point];
}

@end
