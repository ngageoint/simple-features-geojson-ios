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
 * Point type
 */
extern NSString * const SFG_TYPE_POINT;

/**
 * Point
 */
@interface SFGPoint : SFGGeometry

/**
 *  Position
 */
@property (nonatomic, strong) SFGPosition *position;

/**
 *  Initialize
 *
 *  @return new point
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param coordinates coordinate positions
 *
 *  @return new point
 */
-(instancetype) initWithCoordinates: (NSArray *) coordinates;

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
 * Get the simple point
 *
 * @return simple point
 */
-(SFPoint *) point;

/**
 * Set the position
 *
 * @param position point position
 */
-(void) setPosition: (SFGPosition *) position;

/**
 *  Get coordinates from a point
 *
 *  @param point simple point
 *
 *  @return coordinates
 */
+(NSArray *) coordinatesFromPoint: (SFPoint *) point;

/**
 *  Get coordinates from a position
 *
 *  @param position position
 *
 *  @return coordinates
 */
+(NSArray *) coordinatesFromPosition: (SFGPosition *) position;

/**
 *  Get a point from coordinates
 *
 *  @param coordinates coordinate positions
 *
 *  @return point
 */
+(SFPoint *) pointFromCoordinates: (NSArray *) coordinates;

/**
 *  Get a point from a position
 *
 *  @param position position
 *
 *  @return point
 */
+(SFPoint *) pointFromPosition: (SFGPosition *) position;

/**
 *  Get a position from coordinates
 *
 *  @param coordinates coordinate positions
 *
 *  @return position
 */
+(SFGPosition *) positionFromCoordinates: (NSArray *) coordinates;

/**
 *  Get a position from a point
 *
 *  @param point simple point
 *
 *  @return position
 */
+(SFGPosition *) positionFromPoint: (SFPoint *) point;

@end
