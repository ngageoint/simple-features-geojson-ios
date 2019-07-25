//
//  SFGPolygon.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometry.h"
#import "SFPolygon.h"
#import "SFGPosition.h"

/**
 * Polygon type
 */
extern NSString * const SFG_TYPE_POLYGON;

/**
 * Polygon
 */
@interface SFGPolygon : SFGGeometry

/**
 *  Initialize
 *
 *  @return new polygon
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param coordinates coordinate positions
 *
 *  @return new polygon
 */
-(instancetype) initWithCoordinates: (NSArray *) coordinates;

/**
 *  Initialize
 *
 *  @param polygon simple polygon
 *
 *  @return new polygon
 */
-(instancetype) initWithPolygon: (SFPolygon *) polygon;

/**
 *  Initialize
 *
 *  @param tree JSON tree
 *
 *  @return new polygon
 */
-(instancetype) initWithTree: (NSDictionary *) tree;

/**
 * Get the simple polygon
 *
 * @return simple polygon
 */
-(SFPolygon *) polygon;

/**
 * Set the coordinates
 *
 * @param coordinates coordinate positions
 */
-(void) setCoordinates: (NSArray *) coordinates;

/**
 *  Get coordinates from a polygon
 *
 *  @param polygon simple polygon
 *
 *  @return coordinates
 */
+(NSMutableArray *) coordinatesFromPolygon: (SFPolygon *) polygon;

/**
 *  Get a polygon from coordiantes
 *
 *  @param coordinates coordinate positions
 *
 *  @return polygon
 */
+(SFPolygon *) polygonFromCoordinates: (NSArray *) coordinates;

@end
