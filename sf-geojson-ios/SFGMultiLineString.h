//
//  SFGMultiLineString.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometry.h"
#import "SFMultiLineString.h"

/**
 * Multi Line String type
 */
extern NSString * const SFG_TYPE_MULTILINESTRING;

/**
 * Multi Line String
 */
@interface SFGMultiLineString : SFGGeometry

/**
 *  Initialize
 *
 *  @return new multi line string
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param coordinates coordinate positions
 *
 *  @return new multi line string
 */
-(instancetype) initWithCoordinates: (NSArray *) coordinates;

/**
 *  Initialize
 *
 *  @param multiLineString simple multi line string
 *
 *  @return new multi line string
 */
-(instancetype) initWithMultiLineString: (SFMultiLineString *) multiLineString;

/**
 *  Initialize
 *
 *  @param tree JSON tree
 *
 *  @return new multi line string
 */
-(instancetype) initWithTree: (NSDictionary *) tree;

/**
 * Get the simple multi line string
 *
 * @return simple multi line string
 */
-(SFMultiLineString *) multiLineString;

/**
 *  Get coordinates from a multi line string
 *
 *  @param multiLineString simple multi line string
 *
 *  @return coordinates
 */
+(NSMutableArray *) coordinatesFromMultiLineString: (SFMultiLineString *) multiLineString;

/**
 *  Get a multi line string from coordinates
 *
 *  @param coordinates coordinate positions
 *
 *  @return multi line string
 */
+(SFMultiLineString *) multiLineStringFromCoordinates: (NSArray *) coordinates;

@end
