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

-(BOOL) isEqualToGeoJSONObject: (SFGGeoJSONObject *) geoJSONObject{
    if (self == geoJSONObject)
        return YES;
    if (geoJSONObject == nil)
        return NO;
    if (self.bbox == nil) {
        if (geoJSONObject.bbox != nil)
            return NO;
    } else if (![self.bbox isEqual:geoJSONObject.bbox])
        return NO;
    if (self.foreignMembers == nil) {
        if (geoJSONObject.foreignMembers != nil)
            return NO;
    } else if (![self.foreignMembers isEqual:geoJSONObject.foreignMembers])
        return NO;
    return YES;
}

-(BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SFGGeoJSONObject class]]) {
        return NO;
    }
    
    return [self isEqualToGeoJSONObject:(SFGGeoJSONObject *)object];
}

-(NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result
        + ((self.bbox == nil) ? 0 : [self.bbox hash]);
    result = prime * result
        + ((self.foreignMembers == nil) ? 0 : [self.foreignMembers hash]);
    return result;
}

+(NSString *) treeType: (NSDictionary *) tree{
    return [tree objectForKey:SFG_MEMBER_TYPE];
}

@end
