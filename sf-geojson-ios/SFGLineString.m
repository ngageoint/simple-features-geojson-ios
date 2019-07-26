//
//  SFGLineString.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGLineString.h"
#import "SFGPoint.h"

NSString * const SFG_TYPE_LINESTRING = @"LineString";

@interface SFGLineString()

/**
 *  Simple line string
 */
@property (nonatomic, strong) SFLineString *lineString;

@end

@implementation SFGLineString

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super initWithCoordinates:coordinates];
    return self;
}

-(instancetype) initWithLineString: (SFLineString *) lineString{
    self = [super init];
    if(self != nil){
        _lineString = lineString;
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(SFLineString *) lineString{
    return _lineString;
}

-(NSArray *) coordinates{
    return [SFGLineString coordinatesFromLineString:self.lineString];
}

-(void) setCoordinates: (NSArray *) coordinates{
    self.lineString = [SFGLineString lineStringFromCoordinates:coordinates];
}

-(SFGeometry *) geometry{
    return [self lineString];
}

-(NSString *) type{
    return SFG_TYPE_LINESTRING;
}

+(NSMutableArray *) coordinatesFromLineString: (SFLineString *) lineString{
    NSMutableArray *coordinates = [[NSMutableArray alloc] init];
    for(SFPoint *point in lineString.points){
        [coordinates addObject:[SFGPoint coordinatesFromPoint:point]];
    }
    return coordinates;
}

+(SFLineString *) lineStringFromCoordinates: (NSArray *) coordinates{
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    for(NSArray *pointCoordinates in coordinates){
        [points addObject:[SFGPoint pointFromCoordinates:pointCoordinates]];
    }
    return [[SFLineString alloc] initWithPoints:points];
}

@end
