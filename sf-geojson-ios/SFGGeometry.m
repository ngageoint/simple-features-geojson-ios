//
//  SFGGeometry.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometry.h"

NSString * const SFG_COORDINATES = @"coordinates";

@implementation SFGGeometry

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super init];
    if(self != nil){
        [self setCoordinates:coordinates];
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(SFGeometry *) geometry{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(NSArray *) coordinates{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(void) setCoordinates: (NSArray *) coordinates{
    [self doesNotRecognizeSelector:_cmd];
}

-(NSMutableDictionary *) toTree{
    NSMutableDictionary *tree = [super toTree];
    NSArray *coordinates = [self coordinates];
    if(coordinates != nil){
        [tree setObject:coordinates forKey:SFG_COORDINATES];
    }
    return tree;
}

-(void) fromTree: (NSDictionary *) tree{
    [super fromTree:tree];
    [self setCoordinates:[SFGGeometry treeCoordinates:tree]];
}

+(NSArray *) treeCoordinates: (NSDictionary *) tree{
    return [tree objectForKey:SFG_COORDINATES];
}

@end
