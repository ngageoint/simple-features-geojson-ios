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
    [tree setObject:[self coordinates] forKey:SFG_COORDINATES];
    return tree;
}

-(void) fromTree: (NSDictionary *) tree{
    [super fromTree:tree];
}

+(NSObject *) treeCoordinates: (NSDictionary *) tree{
    return [tree objectForKey:SFG_COORDINATES];
}

@end
