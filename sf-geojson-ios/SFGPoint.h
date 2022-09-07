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
 *  Position
 */
@property (nonatomic, strong) SFGPosition *position;

/**
 *  Create
 *
 *  @return new point
 */
+(SFGPoint *) point;

/**
 *  Create
 *
 *  @param coordinates coordinate positions
 *
 *  @return new point
 */
+(SFGPoint *) pointWithCoordinates: (NSArray *) coordinates;

/**
 *  Create
 *
 *  @param position position
 *
 *  @return new point
 */
+(SFGPoint *) pointWithPosition: (SFGPosition *) position;

/**
 *  Create
 *
 *  @param point simple point
 *
 *  @return new point
 */
+(SFGPoint *) pointWithPoint: (SFPoint *) point;

/**
 *  Create
 *
 *  @param tree JSON tree
 *
 *  @return new point
 */
+(SFGPoint *) pointWithTree: (NSDictionary *) tree;

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

@end
