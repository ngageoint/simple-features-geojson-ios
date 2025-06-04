//
//  SFGPoint.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import <SimpleFeaturesGeoJSON/SFGPoint.h>

@implementation SFGPoint

+(SFGPoint *) point{
    return [[SFGPoint alloc] init];
}

+(SFGPoint *) pointWithCoordinates: (NSArray *) coordinates{
    return [[SFGPoint alloc] initWithCoordinates:coordinates];
}

+(SFGPoint *) pointWithPosition: (SFGPosition *) position{
    return [[SFGPoint alloc] initWithPosition:position];
}

+(SFGPoint *) pointWithPoint: (SFPoint *) point{
    return [[SFGPoint alloc] initWithPoint:point];
}

+(SFGPoint *) pointWithTree: (NSDictionary *) tree{
    return [[SFGPoint alloc] initWithTree:tree];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super initWithCoordinates:coordinates];
    return self;
}

-(instancetype) initWithPosition: (SFGPosition *) position{
    self = [super init];
    if(self != nil){
        _position = position;
    }
    return self;
}

-(instancetype) initWithPoint: (SFPoint *) point{
    self = [super init];
    if(self != nil){
        [self setPoint:point];
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(SFGGeometryType) geometryType{
    return SFG_POINT;
}

-(SFGeometry *) geometry{
    return (SFGeometry *)[self point];
}

-(SFPoint *) point{
    return [_position toSimplePoint];
}

-(void) setPoint: (SFPoint *) point{
    _position = [SFGPosition positionWithPoint:point];
}

-(NSArray *) coordinates{
    return _position.coordinates;
}

-(void) setCoordinates: (NSArray *) coordinates{
    _position = [SFGPosition positionWithCoordinates:coordinates];
}

-(BOOL) isEqualToPoint: (SFGPoint *) point{
    if (self == point)
        return YES;
    if (point == nil)
        return NO;
    if (![super isEqual:point])
        return NO;
    if (self.position == nil) {
        if (point.position != nil)
            return NO;
    } else if (![self.position isEqual:point.position])
        return NO;
    return YES;
}

-(BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SFGPoint class]]) {
        return NO;
    }
    
    return [self isEqualToPoint:(SFGPoint *)object];
}

-(NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result
        + ((self.position == nil) ? 0 : [self.position hash]);
    return result;
}

@end
