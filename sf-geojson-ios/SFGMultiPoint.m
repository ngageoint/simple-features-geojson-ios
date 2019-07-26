//
//  SFGMultiPoint.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGMultiPoint.h"
#import "SFGPoint.h"

NSString * const SFG_TYPE_MULTIPOINT = @"MultiPoint";

@interface SFGMultiPoint()

/**
 *  Simple multi point
 */
@property (nonatomic, strong) SFMultiPoint *multiPoint;

@end

@implementation SFGMultiPoint

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super initWithCoordinates:coordinates];
    return self;
}

-(instancetype) initWithMultiPoint: (SFMultiPoint *) multiPoint{
    self = [super init];
    if(self != nil){
        _multiPoint = multiPoint;
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(SFMultiPoint *) multiPoint{
    return _multiPoint;
}

-(NSArray *) coordinates{
    return [SFGMultiPoint coordinatesFromMultiPoint:self.multiPoint];
}

-(void) setCoordinates: (NSArray *) coordinates{
    self.multiPoint = [SFGMultiPoint multiPointFromCoordinates:coordinates];
}

-(SFGeometry *) geometry{
    return [self multiPoint];
}

-(NSString *) type{
    return SFG_TYPE_MULTIPOINT;
}

+(NSMutableArray *) coordinatesFromMultiPoint: (SFMultiPoint *) multiPoint{
    NSMutableArray *coordinates = [[NSMutableArray alloc] init];
    for(SFPoint *point in multiPoint.geometries){
        [coordinates addObject:[SFGPoint coordinatesFromPoint:point]];
    }
    return coordinates;
}

+(SFMultiPoint *) multiPointFromCoordinates: (NSArray *) coordinates{
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    for(NSArray *pointCoordinates in coordinates){
        SFPoint *point = [SFGPoint pointFromCoordinates:pointCoordinates];
        [points addObject:point];
    }
    return [[SFMultiPoint alloc] initWithPoints:points];
}

@end
