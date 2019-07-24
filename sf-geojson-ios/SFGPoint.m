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
        _position = [[SFGPosition alloc] initWithPoint:point];
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super init];
    if(self != nil){
        [self fromTree:tree];
    }
    return self;
}

-(SFPoint *) point{
    return _point;
}

-(NSObject *) coordinates{
    return [_position coordinates];
}

-(void) setPosition: (SFGPosition *) position{
    _point = [[SFPoint alloc] initWithX:[position x] andY:[position y] andZ:[position z] andM:[position m]];
    _position = position;
}

-(SFGeometry *) geometry{
    return _point;
}

-(NSString *) type{
    return SFG_TYPE_POINT;
}

-(void) fromTree: (NSDictionary *) tree{
    [super fromTree:tree];
    NSArray *coordinates = (NSArray *)[SFGGeometry treeCoordinates:tree];
    SFGPosition *position = [[SFGPosition alloc] initWithCoordinates:coordinates];
    [self setPosition:position];
}

@end
