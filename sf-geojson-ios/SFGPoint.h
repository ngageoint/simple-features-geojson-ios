//
//  SFGPoint.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometry.h"
#import "SFPoint.h"
#import "SFGPosition.h"

/**
 * Point
 */
@interface SFGPoint : SFGGeometry

/**
 *  Initialize
 *
 *  @return new point
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param position position
 *
 *  @return new point
 */
-(instancetype) initWithPosition: (SFGPosition *) position;

/**
 *  Initialize
 *
 *  @param point simple point
 *
 *  @return new point
 */
-(instancetype) initWithPoint: (SFPoint *) point;

/**
 *  Initialize
 *
 *  @param tree JSON tree
 *
 *  @return new point
 */
-(instancetype) initWithTree: (NSDictionary *) tree;

/**
 * Sets the new position (supporting deserialization)
 *
 * @param position
 *            point position
 */
-(void) setCoordinates: (SFGPosition *) position;

@end
