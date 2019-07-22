//
//  SFGFeature.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGFeature.h"
#import "SFGFeatureConverter.h"

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
    self = [super init];
    if(self != nil){
        self.feature = [[SFGSimpleFeature alloc] init];
        [self setGeometry:geometry];
    }
    return self;
}

-(SFGGeometry *) geometry{
    return [SFGFeatureConverter simpleGeometryToGeometry:self.feature.geometry];
}

-(void) setGeometry: (SFGGeometry *) geometry{
    if([[geometry type] isEqualToString:SFG_TYPE_POINT]){
        SFGPoint *point = (SFGPoint *) geometry;
        [self.feature setGeometry:[point geometry]];
    }else{
        [self.feature setGeometry:(geometry == nil) ? nil : [geometry geometry]];
    }
}

-(NSMutableDictionary<NSString *, NSObject *> *) properties{
    return self.feature.properties;
}

-(void) setProperties: (NSMutableDictionary<NSString *, NSObject *> *) properties{
    [self.feature setProperties:properties];
}

-(SFGSimpleFeature *) feature{
    return self.feature;
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
    [tree setObject:[[self geometry] toTree] forKey:SFG_GEOMETRY];
    NSMutableDictionary<NSString *, NSObject *> *properties = [self properties];
    if(properties != nil){
        [tree setObject:properties forKey:SFG_PROPERTIES];
    }
    return tree;
}

-(void) fromTree: (NSDictionary *) tree{
    [super fromTree:tree];
    self.id = [tree objectForKey:SFG_ID];
    NSDictionary *geometryTree = [tree objectForKey:SFG_GEOMETRY];
    SFGGeometry *geometry = [SFGFeatureConverter treeToGeometry:geometryTree];
    [self setGeometry:geometry];
    self.properties = [tree objectForKey:SFG_PROPERTIES];
}

@end
