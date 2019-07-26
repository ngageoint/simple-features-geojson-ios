//
//  SFGMultiLineString.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGMultiLineString.h"
#import "SFGLineString.h"

NSString * const SFG_TYPE_MULTILINESTRING = @"MultiLineString";

@interface SFGMultiLineString()

/**
 *  Simple multi line string
 */
@property (nonatomic, strong) SFMultiLineString *multiLineString;

@end

@implementation SFGMultiLineString

-(instancetype) init{
    self = [super init];
    return self;
}

-(instancetype) initWithCoordinates: (NSArray *) coordinates{
    self = [super initWithCoordinates:coordinates];
    return self;
}

-(instancetype) initWithMultiLineString: (SFMultiLineString *) multiLineString{
    self = [super init];
    if(self != nil){
        _multiLineString = multiLineString;
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(SFMultiLineString *) multiLineString{
    return _multiLineString;
}

-(NSArray *) coordinates{
    return [SFGMultiLineString coordinatesFromMultiLineString:self.multiLineString];
}

-(void) setCoordinates: (NSArray *) coordinates{
    self.multiLineString = [SFGMultiLineString multiLineStringFromCoordinates:coordinates];
}

-(SFGeometry *) geometry{
    return [self multiLineString];
}

-(NSString *) type{
    return SFG_TYPE_MULTILINESTRING;
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
