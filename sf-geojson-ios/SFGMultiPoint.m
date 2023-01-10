//
//  SFGMultiPoint.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGMultiPoint.h"

@implementation SFGMultiPoint

+(SFGMultiPoint *) multiPoint{
    return [[SFGMultiPoint alloc] init];
}

+(SFGMultiPoint *) multiPointWithCoordinates: (NSArray *) coordinates{
    return [[SFGMultiPoint alloc] initWithCoordinates:coordinates];
}

+(SFGMultiPoint *) multiPointWithPoints: (NSArray<SFGPoint *> *) points{
    return [[SFGMultiPoint alloc] initWithPoints:points];
}

+(SFGMultiPoint *) multiPointWithMultiPoint: (SFMultiPoint *) multiPoint{
    return [[SFGMultiPoint alloc] initWithMultiPoint:multiPoint];
}

+(SFGMultiPoint *) multiPointWithTree: (NSDictionary *) tree{
    return [[SFGMultiPoint alloc] initWithTree:tree];
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

-(instancetype) initWithMultiPoint: (SFMultiPoint *) multiPoint{
    self = [super init];
    if(self != nil){
        [self setMultiPoint:multiPoint];
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(enum SFGGeometryType) geometryType{
    return SFG_MULTIPOINT;
}

-(SFGeometry *) geometry{
    return [self multiPoint];
}

-(SFMultiPoint *) multiPoint{
    NSMutableArray<SFPoint *> *simplePoints = [NSMutableArray array];
    for(SFGPoint *point in _points){
        [simplePoints addObject:[point point]];
    }
    return [SFMultiPoint multiPointWithPoints:simplePoints];
}

-(void) setMultiPoint: (SFMultiPoint *) multiPoint{
    _points = [NSMutableArray array];
    for(SFPoint *point in multiPoint.points){
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

-(BOOL) isEqualToMultiPoint: (SFGMultiPoint *) multiPoint{
    if (self == multiPoint)
        return YES;
    if (multiPoint == nil)
        return NO;
    if (![super isEqual:multiPoint])
        return NO;
    if (self.points == nil) {
        if (multiPoint.points != nil)
            return NO;
    } else if (![self.points isEqual:multiPoint.points])
        return NO;
    return YES;
}

-(BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SFGMultiPoint class]]) {
        return NO;
    }
    
    return [self isEqualToMultiPoint:(SFGMultiPoint *)object];
}

-(NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result
        + ((self.points == nil) ? 0 : [self.points hash]);
    return result;
}

@end
