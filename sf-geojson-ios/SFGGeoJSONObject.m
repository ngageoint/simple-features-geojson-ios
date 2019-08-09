//
//  SFGGeoJSONObject.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeoJSONObject.h"
#import "SFGOrderedDictionary.h"

NSString * const SFG_TYPE = @"type";

NSString * const SFG_BBOX = @"bbox";

@implementation SFGGeoJSONObject

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super init];
    if(self != nil){
        [self fromTree:tree];
    }
    return self;
}

-(NSString *) type{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(NSMutableDictionary *) toTree{
    NSMutableDictionary *tree = [[SFGOrderedDictionary alloc] init];
    [tree setObject:[self type] forKey:SFG_TYPE];
    if(self.bbox != nil){
        [tree setObject:self.bbox forKey:SFG_BBOX];
    }
    return tree;
}

-(void) fromTree: (NSDictionary *) tree{
    NSArray *boundingBox = (NSArray *)[tree objectForKey:SFG_BBOX];
    if(boundingBox != nil){
        self.bbox = [[NSMutableArray alloc] init];
        for(NSNumber *number in boundingBox){
            [self.bbox addObject:[[NSDecimalNumber alloc] initWithDouble:[number doubleValue]]];
        }
    }
}

+(NSString *) treeType: (NSDictionary *) tree{
    return [tree objectForKey:SFG_TYPE];
}

@end
