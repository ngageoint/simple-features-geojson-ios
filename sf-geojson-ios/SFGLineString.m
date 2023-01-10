//
//  SFGLineString.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGLineString.h"

@implementation SFGLineString

+(SFGLineString *) lineString{
    return [[SFGLineString alloc] init];
}

+(SFGLineString *) lineStringWithCoordinates: (NSArray *) coordinates{
    return [[SFGLineString alloc] initWithCoordinates:coordinates];
}

+(SFGLineString *) lineStringWithPoints: (NSArray<SFGPoint *> *) points{
    return [[SFGLineString alloc] initWithPoints:points];
}

+(SFGLineString *) lineStringWithLineString: (SFLineString *) lineString{
    return [[SFGLineString alloc] initWithLineString:lineString];
}

+(SFGLineString *) lineStringWithTree: (NSDictionary *) tree{
    return [[SFGLineString alloc] initWithTree:tree];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super initWithCoordinates:coordinates];
    return self;
}

-(instancetype) initWithPoints: (NSArray<SFGPoint *> *) points{
    self = [super init];
    if(self != nil){
        _points = [NSMutableArray arrayWithArray:points];
    }
    return self;
}

-(instancetype) initWithLineString: (SFLineString *) lineString{
    self = [super init];
    if(self != nil){
        [self setLineString:lineString];
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(enum SFGGeometryType) geometryType{
    return SFG_LINESTRING;
}

-(SFGeometry *) geometry{
    return [self lineString];
}

-(SFLineString *) lineString{
    NSMutableArray<SFPoint *> *simplePoints = [NSMutableArray array];
    for(SFGPoint *point in _points){
        [simplePoints addObject:[point point]];
    }
    return [SFLineString lineStringWithPoints:simplePoints];
}

-(void) setLineString: (SFLineString *) lineString{
    _points = [NSMutableArray array];
    for(SFPoint *point in lineString.points){
        [_points addObject:[SFGPoint pointWithPoint:point]];
    }
}

-(NSArray *) coordinates{
    NSMutableArray *coordinates = [NSMutableArray array];
    for(SFGPoint *point in _points){
        [coordinates addObject:[point coordinates]];
    }
    return coordinates;
}

-(void) setCoordinates: (NSArray *) coordinates{
    _points = [NSMutableArray array];
    for(NSArray *pointCoordinates in coordinates){
        [_points addObject:[SFGPoint pointWithCoordinates:pointCoordinates]];
    }
}

-(BOOL) isEqualToLineString: (SFGLineString *) lineString{
    if (self == lineString)
        return YES;
    if (lineString == nil)
        return NO;
    if (![super isEqual:lineString])
        return NO;
    if (self.points == nil) {
        if (lineString.points != nil)
            return NO;
    } else if (![self.points isEqual:lineString.points])
        return NO;
    return YES;
}

-(BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SFGLineString class]]) {
        return NO;
    }
    
    return [self isEqualToLineString:(SFGLineString *)object];
}

-(NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result
        + ((self.points == nil) ? 0 : [self.points hash]);
    return result;
}

@end
