//
//  SFGMultiPolygon.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometry.h"
#import "SFMultiPolygon.h"

/**
 * Multi Polygon type
 */
extern NSString * const SFG_TYPE_MULTI_POLYGON;

/**
 * Multi Polygon
 */
@interface SFGMultiPolygon : SFGGeometry

/**
 *  Initialize
 *
 *  @return new multi polygon
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param coordinates coordinate positions
 *
 *  @return new multi polygon
 */
-(instancetype) initWithCoordinates: (NSArray *) coordinates;

/**
 *  Initialize
 *
 *  @param multiPolygon simple multi polygon
 *
 *  @return new multi polygon
 */
-(instancetype) initWithMultiPolygon: (SFMultiPolygon *) multiPolygon;

/**
 *  Initialize
 *
 *  @param tree JSON tree
 *
 *  @return new multi polygon
 */
-(instancetype) initWithTree: (NSDictionary *) tree;

/**
 * Get the simple multi polygon
 *
 * @return simple multi polygon
 */
-(SFMultiPolygon *) multiPolygon;

/**
 *  Get coordinates from a multi polygon
 *
 *  @param multiPolygon simple multi polygon
 *
 *  @return coordinates
 */
+(NSMutableArray *) coordinatesFromMultiPolygon: (SFMultiPolygon *) multiPolygon;

/**
 *  Get a multi polygon from coordinates
 *
 *  @param coordinates coordinate positions
 *
 *  @return multi polygon
 */
+(SFMultiPolygon *) multiPolygonFromCoordinates: (NSArray *) coordinates;

@end
