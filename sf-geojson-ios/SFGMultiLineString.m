//
//  SFGMultiLineString.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import <SimpleFeaturesGeoJSON/SFGMultiLineString.h>

@import SimpleFeatures;

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

-(SFGGeometryType) geometryType{
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

-(BOOL) isEqualToMultiLineString: (SFGMultiLineString *) multiLineString{
    if (self == multiLineString)
        return YES;
    if (multiLineString == nil)
        return NO;
    if (![super isEqual:multiLineString])
        return NO;
    if (self.lineStrings == nil) {
        if (multiLineString.lineStrings != nil)
            return NO;
    } else if (![self.lineStrings isEqual:multiLineString.lineStrings])
        return NO;
    return YES;
}

-(BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SFGMultiLineString class]]) {
        return NO;
    }
    
    return [self isEqualToMultiLineString:(SFGMultiLineString *)object];
}

-(NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result
        + ((self.lineStrings == nil) ? 0 : [self.lineStrings hash]);
    return result;
}

@end
