//
//  SFGMultiPoint.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometry.h"
#import "SFGPoint.h"
#import "SFMultiPoint.h"

/**
 * Multi Point
 */
@interface SFGMultiPoint : SFGGeometry

/**
 *  Array of points
 */
@property (nonatomic, strong) NSMutableArray<SFGPoint *> *points;

/**
 *  Initialize
 *
 *  @return new multi point
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param coordinates coordinate positions
 *
 *  @return new multi point
 */
-(instancetype) initWithCoordinates: (NSArray *) coordinates;

/**
 *  Initialize
 *
 *  @param points points list
 *
 *  @return new multi point
 */
-(instancetype) initWithPoints: (NSArray<SFGPoint *> *) points;

/**
 *  Initialize
 *
 *  @param multiPoint simple multi point
 *
 *  @return new multi point
 */
-(instancetype) initWithMultiPoint: (SFMultiPoint *) multiPoint;

/**
 *  Initialize
 *
 *  @param tree JSON tree
 *
 *  @return new multi point
 */
-(instancetype) initWithTree: (NSDictionary *) tree;

/**
 * Get the simple features multi point
 *
 * @return multi point
 */
-(SFMultiPoint *) multiPoint;

/**
 * Set the simple features multi point
 *
 * @param multiPoint multi point
 */
-(void) setMultiPoint: (SFMultiPoint *) multiPoint;

/**
 *  Get coordinates from a multi point
 *
 *  @param multiPoint simple multi point
 *
 *  @return coordinates
 */
+(NSMutableArray *) coordinatesFromMultiPoint: (SFMultiPoint *) multiPoint;

/**
 *  Get a multi point from coordinates
 *
 *  @param coordinates coordinate positions
 *
 *  @return multi point
 */
+(SFMultiPoint *) multiPointFromCoordinates: (NSArray *) coordinates;

@end
