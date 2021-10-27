//
//  SFGGeoJSONObject.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeoJSONObject.h"
#import "SFGOrderedDictionary.h"

NSString * const SFG_MEMBER_TYPE = @"type";

NSString * const SFG_MEMBER_BBOX = @"bbox";

@implementation SFGGeoJSONObject

-(instancetype) init{
    self = [super init];
    if(self != nil){
        self.foreignMembers = [NSMutableDictionary dictionary];
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

-(NSString *) type{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(NSMutableDictionary *) toTree{
    NSMutableDictionary *tree = [[SFGOrderedDictionary alloc] init];
    [tree setObject:[self type] forKey:SFG_MEMBER_TYPE];
    if(self.bbox != nil){
        [tree setObject:self.bbox forKey:SFG_MEMBER_BBOX];
    }
    if(self.foreignMembers != nil && self.foreignMembers.count > 0){
        [tree addEntriesFromDictionary:self.foreignMembers];
    }
    return tree;
}

-(void) fromTree: (NSDictionary *) tree{
    NSArray *boundingBox = (NSArray *)[tree objectForKey:SFG_MEMBER_BBOX];
    if(boundingBox != nil){
        self.bbox = [NSMutableArray array];
        for(NSNumber *number in boundingBox){
            [self.bbox addObject:[[NSDecimalNumber alloc] initWithDouble:[number doubleValue]]];
        }
    }
    self.foreignMembers = [NSMutableDictionary dictionary];
    NSOrderedSet<NSString *> *keys = [self keys];
    if(keys != nil && keys.count > 0){
        for(NSString *key in [tree allKeys]){
            if(![keys containsObject:key]){
                [self.foreignMembers setObject:[tree objectForKey:key] forKey:key];
            }
        }
    }
}

-(NSOrderedSet<NSString *> *) keys{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

+(NSString *) treeType: (NSDictionary *) tree{
    return [tree objectForKey:SFG_MEMBER_TYPE];
}

@end
