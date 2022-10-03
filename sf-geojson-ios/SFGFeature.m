//
//  SFGFeature.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGFeature.h"
#import "SFGFeatureConverter.h"
#import "SFGOrderedDictionary.h"

NSString * const SFG_TYPE_FEATURE = @"Feature";

NSString * const SFG_MEMBER_ID = @"id";

NSString * const SFG_MEMBER_GEOMETRY = @"geometry";

NSString * const SFG_MEMBER_PROPERTIES = @"properties";

static NSOrderedSet *keys = nil;

@implementation SFGFeature

+(void) initialize {
    if(keys == nil){
        keys = [NSOrderedSet orderedSetWithObjects:SFG_MEMBER_TYPE, SFG_MEMBER_BBOX, SFG_MEMBER_ID, SFG_MEMBER_GEOMETRY, SFG_MEMBER_PROPERTIES, nil];
    }
}

+(SFGFeature *) feature{
    return [[SFGFeature alloc] init];
}

+(SFGFeature *) featureWithGeometry: (SFGGeometry *) geometry{
    return [[SFGFeature alloc] initWithGeometry:geometry];
}

+(SFGFeature *) featureWithTree: (NSDictionary *) tree{
    return [[SFGFeature alloc] initWithTree:tree];
}

-(instancetype) init{
    self = [super init];
    if(self != nil){
        _properties = [[SFGOrderedDictionary alloc] init];
    }
    return self;
}

-(instancetype) initWithGeometry: (SFGGeometry *) geometry{
    self = [self init];
    if(self != nil){
        _geometry = geometry;
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(SFGeometry *) simpleGeometry{
    return _geometry != nil ? [_geometry geometry] : nil;
}

-(enum SFGGeometryType) geometryType{
    return _geometry != nil ? [_geometry geometryType] : -1;
}

-(NSString *) type{
    return SFG_TYPE_FEATURE;
}

-(NSMutableDictionary *) toTree{
    NSMutableDictionary *tree = [super toTree];
    if(self.id != nil){
        [tree setObject:self.id forKey:SFG_MEMBER_ID];
    }
    SFGGeometry *geometry = [self geometry];
    NSMutableDictionary *geometryTree = nil;
    if(geometry != nil){
        geometryTree = [geometry toTree];
    }
    [tree setObject:geometryTree != nil ? geometryTree : [NSNull null] forKey:SFG_MEMBER_GEOMETRY];
    NSMutableDictionary<NSString *, NSObject *> *properties = [self properties];
    if(properties == nil){
        properties = [[SFGOrderedDictionary alloc] init];
    }
    [tree setObject:properties forKey:SFG_MEMBER_PROPERTIES];
    return tree;
}

-(void) fromTree: (NSDictionary *) tree{
    [super fromTree:tree];
    self.id = [tree objectForKey:SFG_MEMBER_ID];
    NSDictionary *geometryTree = [tree objectForKey:SFG_MEMBER_GEOMETRY];
    SFGGeometry *geometry = nil;
    if(![geometryTree isEqual:[NSNull null]] && geometryTree != nil){
        geometry = [SFGFeatureConverter treeToGeometry:geometryTree];
    }
    [self setGeometry:geometry];
    NSDictionary *propertiesTree = [tree objectForKey:SFG_MEMBER_PROPERTIES];
    NSMutableDictionary<NSString *, NSObject *> *properties = [[SFGOrderedDictionary alloc] init];
    if(![propertiesTree isEqual:[NSNull null]] && propertiesTree != nil){
        for(NSString *propertyKey in [propertiesTree allKeys]){
            [properties setObject:[propertiesTree objectForKey:propertyKey] forKey:propertyKey];
        }
    }
    [self setProperties:properties];
}

-(NSOrderedSet<NSString *> *) keys{
    return keys;
}

-(BOOL) isEqualToFeature: (SFGFeature *) feature{
    if (self == feature)
        return YES;
    if (feature == nil)
        return NO;
    if (![super isEqual:feature])
        return NO;
    if (self.id == nil) {
        if (feature.id != nil)
            return NO;
    } else if (![self.id isEqual:feature.id])
        return NO;
    if (self.geometry == nil) {
        if (feature.geometry != nil)
            return NO;
    } else if (![self.geometry isEqual:feature.geometry])
        return NO;
    if (self.properties == nil) {
        if (feature.properties != nil)
            return NO;
    } else if (![self.properties isEqual:feature.properties])
        return NO;
    return YES;
}

-(BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SFGFeature class]]) {
        return NO;
    }
    
    return [self isEqualToFeature:(SFGFeature *)object];
}

-(NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result
        + ((self.id == nil) ? 0 : [self.id hash]);
    result = prime * result
        + ((self.geometry == nil) ? 0 : [self.geometry hash]);
    result = prime * result
        + ((self.properties == nil) ? 0 : [self.properties hash]);
    return result;
}

@end
