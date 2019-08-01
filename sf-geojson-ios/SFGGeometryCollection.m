//
//  SFGGeometryCollection.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometryCollection.h"
#import "SFGFeatureConverter.h"

NSString * const SFG_TYPE_GEOMETRYCOLLECTION = @"GeometryCollection";

NSString * const SFG_GEOMETRIES = @"geometries";

@interface SFGGeometryCollection()

/**
 *  Simple geometry collection
 */
@property (nonatomic, strong) SFGeometryCollection *geometryCollection;

@end

@implementation SFGGeometryCollection

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super initWithCoordinates:coordinates];
    return self;
}

-(instancetype) initWithGeometryCollection: (SFGeometryCollection *) geometryCollection{
    self = [super init];
    if(self != nil){
        _geometryCollection = geometryCollection;
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(SFGeometryCollection *) geometryCollection{
    return _geometryCollection;
}

-(NSArray *) coordinates{
    return nil;
}

-(void) setCoordinates: (NSArray *) coordinates{

}

-(NSMutableDictionary *) toTree{
    NSMutableDictionary *tree = [super toTree];
    NSMutableArray *geometries = [SFGGeometryCollection geometriesFromGeometryCollection:self.geometryCollection];
    [tree setObject:geometries forKey:SFG_GEOMETRIES];
    return tree;
}

-(void) fromTree: (NSDictionary *) tree{
    [super fromTree:tree];
    NSArray *geometries = [SFGGeometryCollection treeGeometries:tree];
    SFGeometryCollection *geometryCollection = [SFGGeometryCollection geometryCollectionFromGeometries:geometries];
    [self setGeometryCollection:geometryCollection];
}

-(SFGeometry *) geometry{
    return [self geometryCollection];
}

-(NSString *) type{
    return SFG_TYPE_GEOMETRYCOLLECTION;
}

+(NSMutableArray *) geometriesFromGeometryCollection: (SFGeometryCollection *) geometryCollection{
    NSMutableArray *geometries = [[NSMutableArray alloc] init];
    for(SFGeometry *geometry in geometryCollection.geometries){
        [geometries addObject:[SFGFeatureConverter simpleGeometryToMutableTree:geometry]];
    }
    return geometries;
}

+(SFGeometryCollection *) geometryCollectionFromGeometries: (NSArray *) geometries{
    NSMutableArray<SFGeometry *> *geometryCollection = [[NSMutableArray alloc] init];
    for(NSDictionary *geometryCoordinates in geometries){
        SFGGeometry *geometry = [SFGFeatureConverter treeToGeometry:geometryCoordinates];
        [geometryCollection addObject:[geometry geometry]];
    }
    return [[SFGeometryCollection alloc] initWithGeometries:geometryCollection];
}

+(NSArray *) treeGeometries: (NSDictionary *) tree{
    return [tree objectForKey:SFG_GEOMETRIES];
}

@end
