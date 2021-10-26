//
//  SFGGeometryCollection.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometry.h"
#import "SFGeometryCollection.h"

/**
 * Geometries key
 */
extern NSString * const SFG_MEMBER_GEOMETRIES;

/**
 * Geometry Collection
 */
@interface SFGGeometryCollection : SFGGeometry

/**
 *  Array of geometries
 */
@property (nonatomic, strong) NSMutableArray<SFGGeometry *> *geometries;

/**
 *  Initialize
 *
 *  @return new geometry collection
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param geometries list of geometries
 *
 *  @return new geometry collection
 */
-(instancetype) initWithGeometries: (NSArray<SFGGeometry *> *) geometries;

/**
 *  Initialize
 *
 *  @param coordinates coordinate positions
 *
 *  @return new geometry collection
 */
-(instancetype) initWithCoordinates: (NSArray *) coordinates;

/**
 *  Initialize
 *
 *  @param geometryCollection simple geometry collection
 *
 *  @return new geometry collection
 */
-(instancetype) initWithGeometryCollection: (SFGeometryCollection *) geometryCollection;

/**
 *  Initialize
 *
 *  @param tree JSON tree
 *
 *  @return new geometry collection
 */
-(instancetype) initWithTree: (NSDictionary *) tree;

/**
 * Get the simple features geometry collection
 *
 * @return geometry collection
 */
-(SFGeometryCollection *) geometryCollection;

/**
 * Set the simple features geometry collection
 *
 * @param geometryCollection geometry collection
 */
-(void) setGeometryCollection: (SFGeometryCollection *) geometryCollection;

/**
 *  Get geometries from a geometry collection
 *
 *  @param geometryCollection simple geometry collection
 *
 *  @return geometries
 */
+(NSMutableArray *) geometriesFromGeometryCollection: (SFGeometryCollection *) geometryCollection;

/**
 *  Get a geometry collection from geometries
 *
 *  @param geometries geometries
 *
 *  @return geometry collection
 */
+(SFGeometryCollection *) geometryCollectionFromGeometries: (NSArray *) geometries;

/**
 * Get the JSON object geometries from the JSON tree
 *
 * @return geometries
 */
+(NSArray *) treeGeometries: (NSDictionary *) tree;

@end
