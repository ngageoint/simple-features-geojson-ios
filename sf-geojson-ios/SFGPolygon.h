//
//  SFGPolygon.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometry.h"
#import "SFGLineString.h"
#import "SFPolygon.h"

/**
 * Polygon
 */
@interface SFGPolygon : SFGGeometry

/**
 *  Array of line string rings
 */
@property (nonatomic, strong) NSMutableArray<SFGLineString *> *rings;

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
