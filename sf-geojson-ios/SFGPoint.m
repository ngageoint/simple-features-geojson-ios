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

/**
 *  Position
 */
@property (nonatomic, strong) SFGPosition *position;

@end

@implementation SFGPoint

-(instancetype) init{
    return [self initWithPoint:[[SFPoint alloc] init]];
}

-(instancetype) initWithPosition: (SFGPosition *) position{
    self = [super init];
    if(self != nil){
        [self setCoordinates:position];
    }
    return self;
}

-(instancetype) initWithPoint: (SFPoint *) point{
    self = [super init];
    if(self != nil){
        self.point = point;
        self.position = [[SFGPosition alloc] initWithPoint:point];
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

-(NSObject *) coordinates{
    return [self.position coordinates];
}

-(void) setCoordinates: (SFGPosition *) position{
    self.point = [[SFPoint alloc] initWithX:[position x] andY:[position y] andZ:[position z] andM:[position m]];
    self.position = position;
}

-(SFGeometry *) geometry{
    return self.point;
}

-(NSString *) type{
    return SFG_TYPE_POINT;
}

-(void) fromTree: (NSDictionary *) tree{
    [super fromTree:tree];
    NSArray *coordinates = (NSArray *)[SFGGeometry treeCoordinates:tree];
    SFGPosition *position = [[SFGPosition alloc] initWithCoordinates:coordinates];
    [self setCoordinates:position];
}

@end
