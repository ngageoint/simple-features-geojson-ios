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

+(SFGMultiLineString *) multiLineString{
    return [[SFGMultiLineString alloc] init];
}

+(SFGMultiLineString *) multiLineStringWithCoordinates: (NSArray *) coordinates{
    return [[SFGMultiLineString alloc] initWithCoordinates:coordinates];
}

+(SFGMultiLineString *) multiLineStringWithLineStrings: (NSArray<SFGLineString *> *) lineStrings{
    return [[SFGMultiLineString alloc] initWithLineStrings:lineStrings];
}

+(SFGMultiLineString *) multiLineStringWithMultiLineString: (SFMultiLineString *) multiLineString{
    return [[SFGMultiLineString alloc] initWithMultiLineString:multiLineString];
}

+(SFGMultiLineString *) multiLineStringWithTree: (NSDictionary *) tree{
    return [[SFGMultiLineString alloc] initWithTree:tree];
}

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
    return [SFMultiLineString multiLineStringWithLineStrings:simpleLineStrings];
}

-(void) setMultiLineString: (SFMultiLineString *) multiLineString{
    _lineStrings = [NSMutableArray array];
    for(SFLineString *lineString in [multiLineString lineStrings]){
        [_lineStrings addObject:[SFGLineString lineStringWithLineString:lineString]];
    }
}

-(NSArray *) coordinates{
    NSMutableArray *coordinates = [NSMutableArray array];
    for(SFGLineString *lineString in _lineStrings){
        [coordinates addObject:[lineString coordinates]];
    }
    return coordinates;
}

-(void) setCoordinates: (NSArray *) coordinates{
    _lineStrings = [NSMutableArray array];
    for(NSArray *lineStringCoordinates in coordinates){
        [_lineStrings addObject:[SFGLineString lineStringWithCoordinates:lineStringCoordinates]];
    }
}

@end
