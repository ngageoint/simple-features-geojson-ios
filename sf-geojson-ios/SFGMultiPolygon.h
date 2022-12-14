//
//  SFGMultiPolygon.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGPolygon.h"
#import "SFMultiPolygon.h"

/**
 * Multi Polygon
 */
@interface SFGMultiPolygon : SFGGeometry

/**
 *  Array of polygons
 */
@property (nonatomic, strong) NSMutableArray<SFGPolygon *> *polygons;

/**
 *  Create
 *
 *  @return new multi polygon
 */
+(SFGMultiPolygon *) multiPolygon;

/**
 *  Create
 *
 *  @param coordinates coordinate positions
 *
 *  @return new multi polygon
 */
+(SFGMultiPolygon *) multiPolygonWithCoordinates: (NSArray *) coordinates;

/**
 *  Create
 *
 *  @param polygons polygon list
 *
 *  @return new multi polygon
 */
+(SFGMultiPolygon *) multiPolygonWithPolygons: (NSArray<SFGPolygon *> *) polygons;

/**
 *  Create
 *
 *  @param multiPolygon simple multi polygon
 *
 *  @return new multi polygon
 */
+(SFGMultiPolygon *) multiPolygonWithMultiPolygon: (SFMultiPolygon *) multiPolygon;

/**
 *  Create
 *
 *  @param tree JSON tree
 *
 *  @return new multi polygon
 */
+(SFGMultiPolygon *) multiPolygonWithTree: (NSDictionary *) tree;

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
 *  @param polygons polygon list
 *
 *  @return new multi polygon
 */
-(instancetype) initWithPolygons: (NSArray<SFGPolygon *> *) polygons;

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
 * Get the simple features multi polygon
 *
 * @return multi polygon
 */
-(SFMultiPolygon *) multiPolygon;

/**
 * Set the simple features multi polygon
 *
 * @param multiPolygon multi polygon
 */
-(void) setMultiPolygon: (SFMultiPolygon *) multiPolygon;

@end
