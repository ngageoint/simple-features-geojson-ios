//
//  SFGMultiPolygon.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGMultiPolygon.h"
#import "SFGPolygon.h"

NSString * const SFG_TYPE_MULTIPOLYGON = @"MultiPolygon";

@interface SFGMultiPolygon()

/**
 *  Simple multi polygon
 */
@property (nonatomic, strong) SFMultiPolygon *multiPolygon;

@end

@implementation SFGMultiPolygon

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super initWithCoordinates:coordinates];
    return self;
}

-(instancetype) initWithMultiPolygon: (SFMultiPolygon *) multiPolygon{
    self = [super init];
    if(self != nil){
        _multiPolygon = multiPolygon;
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(SFMultiPolygon *) multiPolygon{
    return _multiPolygon;
}

-(NSArray *) coordinates{
    return [SFGMultiPolygon coordinatesFromMultiPolygon:self.multiPolygon];
}

-(void) setCoordinates: (NSArray *) coordinates{
    self.multiPolygon = [SFGMultiPolygon multiPolygonFromCoordinates:coordinates];
}

-(SFGeometry *) geometry{
    return [self multiPolygon];
}

-(NSString *) type{
    return SFG_TYPE_MULTIPOLYGON;
}

+(NSMutableArray *) coordinatesFromMultiPolygon: (SFMultiPolygon *) multiPolygon{
    NSMutableArray *coordinates = [[NSMutableArray alloc] init];
    for(SFPolygon *polygon in multiPolygon.geometries){
        [coordinates addObject:[SFGPolygon coordinatesFromPolygon:polygon]];
    }
    return coordinates;
}

+(SFMultiPolygon *) multiPolygonFromCoordinates: (NSArray *) coordinates{
    NSMutableArray<SFPolygon *> *polygons = [[NSMutableArray alloc] init];
    for(NSArray *polygonCoordinates in coordinates){
        SFPolygon *polygon = [SFGPolygon polygonFromCoordinates:polygonCoordinates];
        [polygons addObject:polygon];
    }
    return [[SFMultiPolygon alloc] initWithPolygons:polygons];
}

@end
