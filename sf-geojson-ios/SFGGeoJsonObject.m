//
//  SFGGeoJsonObject.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeoJsonObject.h"

@implementation SFGGeoJsonObject

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
    [tree setObject:[self type] forKey:@"type"];
    // TODO bbox
    return tree;
}

-(void) fromTree: (NSDictionary *) tree{
    // TODO bbox
}

@end
