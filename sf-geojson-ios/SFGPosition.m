//
//  SFGPosition.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGPosition.h"

@implementation SFGPosition

+(SFGPosition *) positionWithPoint: (SFPoint *) point{
    return [[SFGPosition alloc] initWithPoint:point];
}

+(SFGPosition *) positionWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude{
    return [[SFGPosition alloc] initWithLongitude:longitude andLatitude:latitude];
}

+(SFGPosition *) positionWithLongitudeValue: (double) longitude andLatitudeValue: (double) latitude{
    return [[SFGPosition alloc] initWithLongitudeValue:longitude andLatitudeValue:latitude];
}

+(SFGPosition *) positionWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude andAltitude: (NSDecimalNumber *) altitude{
    return [[SFGPosition alloc] initWithLongitude:longitude andLatitude:latitude andAltitude:altitude];
}

+(SFGPosition *) positionWithLongitudeValue: (double) longitude andLatitudeValue: (double) latitude andAltitudeValue: (double) altitude{
    return [[SFGPosition alloc] initWithLongitudeValue:longitude andLatitudeValue:latitude andAltitudeValue:altitude];
}

+(SFGPosition *) positionWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude andAltitude: (NSDecimalNumber *) altitude andAdditional: (NSDecimalNumber *) additionalElement{
    return [[SFGPosition alloc] initWithLongitude:longitude andLatitude:latitude andAltitude:altitude andAdditional:additionalElement];
}

+(SFGPosition *) positionWithLongitudeValue: (double) longitude andLatitudeValue: (double) latitude andAltitudeValue: (double) altitude andAdditionalValue: (double) additionalElement{
    return [[SFGPosition alloc] initWithLongitudeValue:longitude andLatitudeValue:latitude andAltitudeValue:altitude andAdditionalValue:additionalElement];
}

+(SFGPosition *) positionWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude andAltitude: (NSDecimalNumber *) altitude andAdditionals: (NSArray<NSDecimalNumber *>*) additionalElements{
    return [[SFGPosition alloc] initWithLongitude:longitude andLatitude:latitude andAltitude:altitude andAdditionals:additionalElements];
}

+(SFGPosition *) positionWithLongitudeValue: (double) longitude andLatitudeValue: (double) latitude andAltitudeValue: (double) altitude andAdditionals: (NSArray<NSDecimalNumber *>*) additionalElements{
    return [[SFGPosition alloc] initWithLongitudeValue:longitude andLatitudeValue:latitude andAltitudeValue:altitude andAdditionals:additionalElements];
}

+(SFGPosition *) positionWithCoordinates: (NSArray *) coordinates{
    return [[SFGPosition alloc] initWithCoordinates:coordinates];
}

-(instancetype) initWithPoint: (SFPoint *) point{
    return [self initWithLongitude:point.x andLatitude:point.y andAltitude:point.z andAdditional:point.m];
}

-(instancetype) initWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude{
    return [self initWithLongitude:longitude andLatitude:latitude andAltitude:nil];
}

-(instancetype) initWithLongitudeValue: (double) longitude andLatitudeValue: (double) latitude{
    return [self initWithLongitude:[[NSDecimalNumber alloc] initWithDouble:longitude] andLatitude:[[NSDecimalNumber alloc] initWithDouble:latitude]];
}

-(instancetype) initWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude andAltitude: (NSDecimalNumber *) altitude{
    return [self initWithLongitude:longitude andLatitude:latitude andAltitude:altitude andAdditionals:nil];
}

-(instancetype) initWithLongitudeValue: (double) longitude andLatitudeValue: (double) latitude andAltitudeValue: (double) altitude{
    return [self initWithLongitude:[[NSDecimalNumber alloc] initWithDouble:longitude] andLatitude:[[NSDecimalNumber alloc] initWithDouble:latitude] andAltitude:[[NSDecimalNumber alloc] initWithDouble:altitude]];
}

-(instancetype) initWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude andAltitude: (NSDecimalNumber *) altitude andAdditional: (NSDecimalNumber *) additionalElement{
    return [self initWithLongitude:longitude andLatitude:latitude andAltitude:altitude andAdditionals:[NSArray arrayWithObjects:additionalElement, nil]];
}

-(instancetype) initWithLongitudeValue: (double) longitude andLatitudeValue: (double) latitude andAltitudeValue: (double) altitude andAdditionalValue: (double) additionalElement{
    return [self initWithLongitude:[[NSDecimalNumber alloc] initWithDouble:longitude] andLatitude:[[NSDecimalNumber alloc] initWithDouble:latitude] andAltitude:[[NSDecimalNumber alloc] initWithDouble:altitude] andAdditional:[[NSDecimalNumber alloc] initWithDouble:additionalElement]];
}

-(instancetype) initWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude andAltitude: (NSDecimalNumber *) altitude andAdditionals: (NSArray<NSDecimalNumber *>*) additionalElements{
    self = [super init];
    if(self != nil){
        
        if (longitude == nil || latitude == nil) {
            _coordinates = [NSMutableArray array];
        } else if (altitude == nil) {
            _coordinates = [NSMutableArray arrayWithObjects:longitude, latitude, nil];
        } else {
            _coordinates = [NSMutableArray arrayWithObjects:longitude, latitude, altitude, nil];
            if(additionalElements != nil && additionalElements.count > 0){
                for(NSDecimalNumber *element in additionalElements){
                    if([element isEqualToNumber:[NSDecimalNumber notANumber]]){
                        [NSException raise:@"NAN" format:@"No additional elements may be NaN."];
                    }
                    [_coordinates addObject:element];
                }
            }
        }
        
    }
    return self;
}

-(instancetype) initWithLongitudeValue: (double) longitude andLatitudeValue: (double) latitude andAltitudeValue: (double) altitude andAdditionals: (NSArray<NSDecimalNumber *>*) additionalElements{
    return [self initWithLongitude:[[NSDecimalNumber alloc] initWithDouble:longitude] andLatitude:[[NSDecimalNumber alloc] initWithDouble:latitude] andAltitude:[[NSDecimalNumber alloc] initWithDouble:altitude] andAdditionals:additionalElements];
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super init];
    if(self != nil){
        _coordinates = [NSMutableArray array];
        for(NSNumber *number in coordinates){
            [_coordinates addObject:[[NSDecimalNumber alloc] initWithDouble:[number doubleValue]]];
        }
    }
    return self;
}

-(BOOL) hasAdditionalElements{
    return _coordinates.count > 3;
}

-(NSArray<NSDecimalNumber *> *) additionalElements{
    return [_coordinates subarrayWithRange:NSMakeRange(3, _coordinates.count - 3)];
}

-(NSDecimalNumber *) x{
    return _coordinates.count > 0 ? [_coordinates objectAtIndex:0] : nil;
}

-(NSDecimalNumber *) y{
    return _coordinates.count > 1 ? [_coordinates objectAtIndex:1] : nil;
}

-(NSDecimalNumber *) z{
    return [self hasZ] ? [_coordinates objectAtIndex:2] : nil;
}

-(NSDecimalNumber *) m{
    return [self hasM] ? [_coordinates objectAtIndex:3] : nil;
}

-(BOOL) hasZ{
    return _coordinates.count > 2;
}

-(BOOL) hasM{
    return _coordinates.count > 3;
}

-(SFPoint *) toSimplePoint{
    SFPoint *point = nil;
    NSDecimalNumber *x = [self x];
    NSDecimalNumber *y = [self y];
    if(x != nil && y != nil){
        point = [SFPoint pointWithX:x andY:y andZ:[self z] andM:[self m]];
    }
    return point;
}

-(BOOL) isEqualToPosition: (SFGPosition *) position{
    if (self == position)
        return YES;
    if (position == nil)
        return NO;
    if (self.coordinates == nil) {
        if (position.coordinates != nil)
            return NO;
    } else if (![self.coordinates isEqual:position.coordinates])
        return NO;
    return YES;
}

-(BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SFGPosition class]]) {
        return NO;
    }
    
    return [self isEqualToPosition:(SFGPosition *)object];
}

-(NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result
        + ((self.coordinates == nil) ? 0 : [self.coordinates hash]);
    return result;
}

@end
