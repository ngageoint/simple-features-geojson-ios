//
//  SFGLineString.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometry.h"
#import "SFLineString.h"

/**
 * Line String type
 */
extern NSString * const SFG_TYPE_LINESTRING;

/**
 * Line String
 */
@interface SFGLineString : SFGGeometry

/**
 *  Initialize
 *
 *  @return new line string
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param coordinates coordinate positions
 *
 *  @return new line string
 */
-(instancetype) initWithCoordinates: (NSArray *) coordinates;

/**
 *  Initialize
 *
 *  @param lineString simple line string
 *
 *  @return new line string
 */
-(instancetype) initWithLineString: (SFLineString *) lineString;

/**
 *  Initialize
 *
 *  @param tree JSON tree
 *
 *  @return new line string
 */
-(instancetype) initWithTree: (NSDictionary *) tree;

/**
 * Get the simple line string
 *
 * @return simple line string
 */
-(SFLineString *) lineString;

/**
 *  Get coordinates from a line string
 *
 *  @param lineString simple line string
 *
 *  @return coordinates
 */
+(NSMutableArray *) coordinatesFromLineString: (SFLineString *) lineString;

/**
 *  Get a line string from coordinates
 *
 *  @param coordinates coordinate positions
 *
 *  @return line string
 */
+(SFLineString *) lineStringFromCoordinates: (NSArray *) coordinates;

@end
