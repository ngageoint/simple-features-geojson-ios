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
    return [SFGGeometryCollection coordinatesFromGeometryCollection:self.geometryCollection];
}

-(void) setCoordinates: (NSArray *) coordinates{
    self.geometryCollection = [SFGGeometryCollection geometryCollectionFromCoordinates:coordinates];
}

-(SFGeometry *) geometry{
    return [self geometryCollection];
}

-(NSString *) type{
    return SFG_TYPE_GEOMETRYCOLLECTION;
}

+(NSMutableArray *) coordinatesFromGeometryCollection: (SFGeometryCollection *) geometryCollection{
    NSMutableArray *geometries = [[NSMutableArray alloc] init];
    for(SFGeometry *geometry in geometryCollection.geometries){
        [geometries addObject:[SFGFeatureConverter simpleGeometryToMutableTree:geometry]];
    }
    return geometries;
}

+(SFGeometryCollection *) geometryCollectionFromCoordinates: (NSArray *) coordinates{
    NSMutableArray<SFGeometry *> *geometries = [[NSMutableArray alloc] init];
    for(NSDictionary *geometryCoordinates in coordinates){
        SFGGeometry *geometry = [SFGFeatureConverter treeToGeometry:geometryCoordinates];
        [geometries addObject:[geometry geometry]];
    }
    return [[SFGeometryCollection alloc] initWithGeometries:geometries];
}

@end
