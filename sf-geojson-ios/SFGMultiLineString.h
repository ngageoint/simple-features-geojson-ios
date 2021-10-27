//
//  SFGMultiLineString.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometry.h"
#import "SFGLineString.h"
#import "SFMultiLineString.h"
/**
 * Multi Line String
 */
@interface SFGMultiLineString : SFGGeometry

/**
 *  Array of line strings
 */
@property (nonatomic, strong) NSMutableArray<SFGLineString *> *lineStrings;

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
 *  @param lineStrings line string list
 *
 *  @return new multi line string
 */
-(instancetype) initWithLineStrings: (NSArray<SFGLineString *> *) lineStrings;

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
 * Get the simple features multi line string
 *
 * @return multi line string
 */
-(SFMultiLineString *) multiLineString;

/**
 * Set the simple features multi line string
 *
 * @param multiLineString multi line string
 */
-(void) setMultiLineString: (SFMultiLineString *) multiLineString;

@end
