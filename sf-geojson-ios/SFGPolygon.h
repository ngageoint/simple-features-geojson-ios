//
//  SFGPolygon.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGLineString.h"
@import sf_ios;

/**
 * Polygon
 */
@interface SFGPolygon : SFGGeometry

/**
 *  Array of line string rings
 */
@property (nonatomic, strong) NSMutableArray<SFGLineString *> *rings;

/**
 *  Create
 *
 *  @return new polygon
 */
+(SFGPolygon *) polygon;

/**
 *  Create
 *
 *  @param coordinates coordinate positions
 *
 *  @return new polygon
 */
+(SFGPolygon *) polygonWithCoordinates: (NSArray *) coordinates;

/**
 *  Create
 *
 *  @param rings ring line string list
 *
 *  @return new polygon
 */
+(SFGPolygon *) polygonWithRings: (NSArray<SFGLineString *> *) rings;

/**
 *  Create
 *
 *  @param polygon simple polygon
 *
 *  @return new polygon
 */
+(SFGPolygon *) polygonWithPolygon: (SFPolygon *) polygon;

/**
 *  Create
 *
 *  @param tree JSON tree
 *
 *  @return new polygon
 */
+(SFGPolygon *) polygonWithTree: (NSDictionary *) tree;

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
 *  @param rings ring line string list
 *
 *  @return new polygon
 */
-(instancetype) initWithRings: (NSArray<SFGLineString *> *) rings;

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
 * @return polygon
 */
-(SFPolygon *) polygon;

/**
 * Set the simple polygon
 *
 * @param polygon polygon
 */
-(void) setPolygon: (SFPolygon *) polygon;

@end
