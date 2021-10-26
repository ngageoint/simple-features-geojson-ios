//
//  SFGMultiLineString.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGMultiLineString.h"
#import "SFGLineString.h"

@implementation SFGMultiLineString

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super initWithCoordinates:coordinates];
    return self;
}

-(instancetype) initWithLineStrings: (NSArray<SFGLineString *> *) lineStrings{
    self = [super init];
    if(self != nil){
        _lineStrings = [NSMutableArray arrayWithArray:lineStrings];
    }
    return self;
}

-(instancetype) initWithMultiLineString: (SFMultiLineString *) multiLineString{
    self = [super init];
    if(self != nil){
        [self setMultiLineString:multiLineString];
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(enum SFGGeometryType) geometryType{
    return SFG_MULTILINESTRING;
}

-(SFGeometry *) geometry{
    return [self multiLineString];
}

-(SFMultiLineString *) multiLineString{
    NSMutableArray<SFLineString *> *simpleLineStrings = [NSMutableArray array];
    for(SFGLineString *lineString in _lineStrings){
        [simpleLineStrings addObject:[lineString lineString]];
    }
    return [[SFMultiLineString alloc] initWithLineStrings:simpleLineStrings];
}

-(void) setMultiLineString: (SFMultiLineString *) multiLineString{
    _lineStrings = [NSMutableArray array];
    for(SFLineString *lineString in [multiLineString lineStrings]){
        [_lineStrings addObject:[[SFGLineString alloc] initWithLineString:lineString]];
    }
}

-(NSArray *) coordinates{
    return [SFGMultiLineString coordinatesFromMultiLineString:self.multiLineString];
}

-(void) setCoordinates: (NSArray *) coordinates{
    self.multiLineString = [SFGMultiLineString multiLineStringFromCoordinates:coordinates];
}

+(NSMutableArray *) coordinatesFromMultiLineString: (SFMultiLineString *) multiLineString{
    NSMutableArray *coordinates = [[NSMutableArray alloc] init];
    for(SFLineString *lineString in multiLineString.geometries){
        [coordinates addObject:[SFGLineString coordinatesFromLineString:lineString]];
    }
    return coordinates;
}

+(SFMultiLineString *) multiLineStringFromCoordinates: (NSArray *) coordinates{
    NSMutableArray<SFLineString *> *lineStrings = [[NSMutableArray alloc] init];
    for(NSArray *lineStringCoordinates in coordinates){
        SFLineString *lineString = [SFGLineString lineStringFromCoordinates:lineStringCoordinates];
        [lineStrings addObject:lineString];
    }
    return [[SFMultiLineString alloc] initWithLineStrings:lineStrings];
}

@end
