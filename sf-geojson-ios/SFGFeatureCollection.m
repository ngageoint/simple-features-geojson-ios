//
//  SFGFeatureCollection.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGFeatureCollection.h"

NSString * const SFG_TYPE_FEATURE_COLLECTION = @"FeatureCollection";

@implementation SFGFeatureCollection

-(NSString *) type{
    return SFG_TYPE_FEATURE_COLLECTION;
}

-(NSMutableDictionary *) toTree{
    NSMutableDictionary *tree = [super toTree];
    // TODO
    return tree;
}

-(void) fromTree: (NSDictionary *) tree{
    [super fromTree:tree];
    // TODO
}

@end
