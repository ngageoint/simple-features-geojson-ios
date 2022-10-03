//
//  SFGGeometryCollection.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometryCollection.h"
#import "SFGFeatureConverter.h"

NSString * const SFG_MEMBER_GEOMETRIES = @"geometries";

static NSOrderedSet *keys = nil;

@implementation SFGGeometryCollection

+(void) initialize{
    if(keys == nil){
        keys = [NSOrderedSet orderedSetWithObjects:SFG_MEMBER_TYPE, SFG_MEMBER_BBOX, SFG_MEMBER_COORDINATES, SFG_MEMBER_GEOMETRIES, nil];
    }
}

+(SFGGeometryCollection *) geometryCollection{
    return [[SFGGeometryCollection alloc] init];
}

+(SFGGeometryCollection *) geometryCollectionWithGeometries: (NSArray<SFGGeometry *> *) geometries{
    return [[SFGGeometryCollection alloc] initWithGeometries:geometries];
}

+(SFGGeometryCollection *) geometryCollectionWithCoordinates: (NSArray *) coordinates{
    return [[SFGGeometryCollection alloc] initWithCoordinates:coordinates];
}

+(SFGGeometryCollection *) geometryCollectionWithGeometryCollection: (SFGeometryCollection *) geometryCollection{
    return [[SFGGeometryCollection alloc] initWithGeometryCollection:geometryCollection];
}

+(SFGGeometryCollection *) geometryCollectionWithTree: (NSDictionary *) tree{
    return [[SFGGeometryCollection alloc] initWithTree:tree];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithGeometries: (NSArray<SFGGeometry *> *) geometries{
    self = [super init];
    if(self != nil){
        _geometries = [NSMutableArray arrayWithArray:geometries];
    }
    return self;
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super initWithCoordinates:coordinates];
    return self;
}

-(instancetype) initWithGeometryCollection: (SFGeometryCollection *) geometryCollection{
    self = [super init];
    if(self != nil){
        [self setGeometryCollection:geometryCollection];
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(enum SFGGeometryType) geometryType{
    return SFG_GEOMETRYCOLLECTION;
}

-(SFGeometry *) geometry{
    return [self geometryCollection];
}

-(SFGeometryCollection *) geometryCollection{
    SFGeometryCollection *simpleGeometryCollection = [SFGeometryCollection geometryCollection];
    for(SFGGeometry *geometry in _geometries){
        [simpleGeometryCollection addGeometry:[geometry geometry]];
    }
    return simpleGeometryCollection;
}

-(void) setGeometryCollection: (SFGeometryCollection *) geometryCollection{
    _geometries = [NSMutableArray array];
    for(SFGeometry *simpleGeometry in geometryCollection.geometries){
        [_geometries addObject:[SFGFeatureConverter simpleGeometryToGeometry:simpleGeometry]];
    }
}

-(NSArray *) coordinates{
    return nil;
}

-(void) setCoordinates: (NSArray *) coordinates{

}

-(NSMutableDictionary *) toTree{
    NSMutableDictionary *tree = [super toTree];
    NSMutableArray *geometries = [SFGGeometryCollection geometriesFromGeometryCollection:self.geometryCollection];
    [tree setObject:geometries forKey:SFG_MEMBER_GEOMETRIES];
    return tree;
}

-(void) fromTree: (NSDictionary *) tree{
    [super fromTree:tree];
    NSArray *geometries = [SFGGeometryCollection treeGeometries:tree];
    SFGeometryCollection *geometryCollection = [SFGGeometryCollection geometryCollectionFromGeometries:geometries];
    [self setGeometryCollection:geometryCollection];
}

-(NSOrderedSet<NSString *> *) keys{
    return keys;
}

-(BOOL) isEqualToGeometryCollection: (SFGGeometryCollection *) geometryCollection{
    if (self == geometryCollection)
        return YES;
    if (geometryCollection == nil)
        return NO;
    if (![super isEqual:geometryCollection])
        return NO;
    if (self.geometries == nil) {
        if (geometryCollection.geometries != nil)
            return NO;
    } else if (![self.geometries isEqual:geometryCollection.geometries])
        return NO;
    return YES;
}

-(BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SFGGeometryCollection class]]) {
        return NO;
    }
    
    return [self isEqualToGeometryCollection:(SFGGeometryCollection *)object];
}

-(NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result
        + ((self.geometries == nil) ? 0 : [self.geometries hash]);
    return result;
}

+(NSMutableArray *) geometriesFromGeometryCollection: (SFGeometryCollection *) geometryCollection{
    NSMutableArray *geometries = [NSMutableArray array];
    for(SFGeometry *geometry in geometryCollection.geometries){
        [geometries addObject:[SFGFeatureConverter simpleGeometryToMutableTree:geometry]];
    }
    return geometries;
}

+(SFGeometryCollection *) geometryCollectionFromGeometries: (NSArray *) geometries{
    NSMutableArray<SFGeometry *> *geometryCollection = [NSMutableArray array];
    for(NSDictionary *geometryCoordinates in geometries){
        SFGGeometry *geometry = [SFGFeatureConverter treeToGeometry:geometryCoordinates];
        [geometryCollection addObject:[geometry geometry]];
    }
    return [SFGeometryCollection geometryCollectionWithGeometries:geometryCollection];
}

+(NSArray *) treeGeometries: (NSDictionary *) tree{
    return [tree objectForKey:SFG_MEMBER_GEOMETRIES];
}

@end
