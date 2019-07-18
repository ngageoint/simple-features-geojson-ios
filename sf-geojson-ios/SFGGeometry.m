//
//  SFGGeometry.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometry.h"

@implementation SFGGeometry

-(SFGeometry *) geometry{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(NSObject *) coordinates{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(NSMutableDictionary *) toTree{
    NSMutableDictionary *tree = [super toTree];
    [tree setObject:[self coordinates] forKey:@"coordinates"];
    return tree;
}

-(void) fromTree: (NSDictionary *) tree{
    [super fromTree:tree];
}

@end
