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

NSString * const SFG_ID = @"id";

NSString * const SFG_GEOMETRY = @"geometry";

NSString * const SFG_PROPERTIES = @"properties";

@interface SFGFeature()

/**
 *  Simple feature
 */
@property (nonatomic, strong) SFGSimpleFeature *feature;

@end

@implementation SFGFeature

-(instancetype) init{
    self = [super init];
    if(self != nil){
        self.feature = [[SFGSimpleFeature alloc] init];
    }
    return self;
}

-(instancetype) initWithGeometry: (SFGGeometry *) geometry{
    self = [self init];
    if(self != nil){
        [self setGeometry:geometry];
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(SFGGeometry *) geometry{
    return [SFGFeatureConverter simpleGeometryToGeometry:self.feature.geometry];
}

-(void) setGeometry: (SFGGeometry *) geometry{
    SFGeometry *simpleGeometry = nil;
    if(geometry != nil){
        simpleGeometry = [geometry geometry];
    }
    [self.feature setGeometry:simpleGeometry];
}

-(NSMutableDictionary<NSString *, NSObject *> *) properties{
    return self.feature.properties;
}

-(void) setProperties: (NSMutableDictionary<NSString *, NSObject *> *) properties{
    [self.feature setProperties:properties];
}

-(SFGSimpleFeature *) feature{
    return _feature;
}

-(SFGeometry *) simpleGeometry{
    return self.feature.geometry;
}

-(enum SFGeometryType) geometryType{
    enum SFGeometryType geometryType = SF_NONE;
    SFGGeometry *geometry = [self geometry];
    if(geometry != nil){
        SFGeometry *simpleGeometry = [geometry geometry];
        if(simpleGeometry != nil){
            geometryType = simpleGeometry.geometryType;
        }
    }
    return geometryType;
}

-(NSString *) type{
    return SFG_TYPE_FEATURE;
}

-(NSMutableDictionary *) toTree{
    NSMutableDictionary *tree = [super toTree];
    if(self.id != nil){
        [tree setObject:self.id forKey:SFG_ID];
    }
    SFGGeometry *geometry = [self geometry];
    NSMutableDictionary *geometryTree = nil;
    if(geometry != nil){
        geometryTree = [geometry toTree];
    }
    [tree setObject:geometryTree != nil ? geometryTree : [NSNull null] forKey:SFG_GEOMETRY];
    NSMutableDictionary<NSString *, NSObject *> *properties = [self properties];
    if(properties == nil){
        properties = [[SFGOrderedDictionary alloc] init];
    }
    [tree setObject:properties forKey:SFG_PROPERTIES];
    return tree;
}

-(void) fromTree: (NSDictionary *) tree{
    [super fromTree:tree];
    self.feature = [[SFGSimpleFeature alloc] init];
    self.id = [tree objectForKey:SFG_ID];
    NSDictionary *geometryTree = [tree objectForKey:SFG_GEOMETRY];
    SFGGeometry *geometry = nil;
    if(![geometryTree isEqual:[NSNull null]] && geometryTree != nil){
        geometry = [SFGFeatureConverter treeToGeometry:geometryTree];
    }
    [self setGeometry:geometry];
    NSDictionary *propertiesTree = [tree objectForKey:SFG_PROPERTIES];
    NSMutableDictionary<NSString *, NSObject *> *properties = [[SFGOrderedDictionary alloc] init];
    if(![propertiesTree isEqual:[NSNull null]] && propertiesTree != nil){
        for(NSString *propertyKey in [propertiesTree allKeys]){
            [properties setObject:[propertiesTree objectForKey:propertyKey] forKey:propertyKey];
        }
    }
    [self setProperties:properties];
}

@end
