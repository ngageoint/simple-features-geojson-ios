//
//  SFGMultiPoint.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGPoint.h"
@import sf_ios;

/**
 * Multi Point
 */
@interface SFGMultiPoint : SFGGeometry

/**
 *  Array of points
 */
@property (nonatomic, strong) NSMutableArray<SFGPoint *> *points;

/**
 *  Create
 *
 *  @return new multi point
 */
+(SFGMultiPoint *) multiPoint;

/**
 *  Create
 *
 *  @param coordinates coordinate positions
 *
 *  @return new multi point
 */
+(SFGMultiPoint *) multiPointWithCoordinates: (NSArray *) coordinates;

/**
 *  Create
 *
 *  @param points points list
 *
 *  @return new multi point
 */
+(SFGMultiPoint *) multiPointWithPoints: (NSArray<SFGPoint *> *) points;

/**
 *  Create
 *
 *  @param multiPoint simple multi point
 *
 *  @return new multi point
 */
+(SFGMultiPoint *) multiPointWithMultiPoint: (SFMultiPoint *) multiPoint;

/**
 *  Create
 *
 *  @param tree JSON tree
 *
 *  @return new multi point
 */
+(SFGMultiPoint *) multiPointWithTree: (NSDictionary *) tree;

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

@end
