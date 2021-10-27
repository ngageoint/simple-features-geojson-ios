//
//  SFGLineString.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometry.h"
#import "SFGPoint.h"
#import "SFLineString.h"

/**
 * Line String
 */
@interface SFGLineString : SFGGeometry

/**
 *  Array of points
 */
@property (nonatomic, strong) NSMutableArray<SFGPoint *> *points;

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
 *  @param points list of points
 *
 *  @return new line string
 */
-(instancetype) initWithPoints: (NSArray<SFGPoint *> *) points;

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
 * Get the simple features line string
 *
 * @return line string
 */
-(SFLineString *) lineString;

/**
 * Set the simple features line string
 *
 * @param lineString line string
 */
-(void) setLineString: (SFLineString *) lineString;

@end
