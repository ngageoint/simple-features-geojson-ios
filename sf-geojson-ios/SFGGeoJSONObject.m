//
//  SFGGeoJSONObject.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeoJSONObject.h"

NSString * const SFG_TYPE = @"type";

@implementation SFGGeoJSONObject

-(NSString *) type{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(NSDictionary *) tree{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(NSMutableDictionary *) toTree{
    NSMutableDictionary *tree = [[NSMutableDictionary alloc] init];
    [tree setObject:[self type] forKey:SFG_TYPE];
    // TODO bbox
    return tree;
}

-(void) fromTree: (NSDictionary *) tree{
    // TODO bbox
}

+(NSString *) treeType: (NSDictionary *) tree{
    return [tree objectForKey:SFG_TYPE];
}

@end
