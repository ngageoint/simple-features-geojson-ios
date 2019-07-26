//
//  SFGMultiPoint.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometry.h"
#import "SFMultiPoint.h"

/**
 * Multi Point type
 */
extern NSString * const SFG_TYPE_MULTI_POINT;

/**
 * Multi Point
 */
@interface SFGMultiPoint : SFGGeometry

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
 * Get the simple multi point
 *
 * @return simple multi point
 */
-(SFMultiPoint *) multiPoint;

/**
 *  Get coordinates from a multi point
 *
 *  @param multiPoint simple multi point
 *
 *  @return coordinates
 */
+(NSMutableArray *) coordinatesFromMultiPoint: (SFMultiPoint *) multiPoint;

/**
 *  Get a multi point from coordiantes
 *
 *  @param coordinates coordinate positions
 *
 *  @return multi point
 */
+(SFMultiPoint *) multiPointFromCoordinates: (NSArray *) coordinates;

@end
