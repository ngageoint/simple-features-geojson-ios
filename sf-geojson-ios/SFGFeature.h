//
//  SFGFeature.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeoJSONObject.h"
#import "SFGGeometry.h"
#import "SFGSimpleFeature.h"

/**
 * Feature type
 */
extern NSString * const SFG_TYPE_FEATURE;

/**
 * Id key
 */
extern NSString * const SFG_ID;

/**
 * Geometry key
 */
extern NSString * const SFG_GEOMETRY;

/**
 * Properties key
 */
extern NSString * const SFG_PROPERTIES;

/**
 * Feature
 */
@interface SFGFeature : SFGGeoJSONObject

/**
 *  Feature id
 */
@property (nonatomic, strong) NSString *id;

/**
 *  Initialize
 *
 *  @return new feature
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param geometry geometry
 *
 *  @return new feature
 */
-(instancetype) initWithGeometry: (SFGGeometry *) geometry;

/**
 *  Initialize
 *
 *  @param tree JSON tree
 *
 *  @return new feature
 */
-(instancetype) initWithTree: (NSDictionary *) tree;

/**
 * Get the geometry
 *
 * @return geometry
 */
-(SFGGeometry *) geometry;

/**
 * Set the geometry
 *
 * @param geometry
 *            geometry object
 */
-(void) setGeometry: (SFGGeometry *) geometry;

/**
 * Get the properties
 *
 * @return properties map
 */
-(NSMutableDictionary<NSString *, NSObject *> *) properties;

/**
 * Set the properties
 *
 * @param properties
 *            properties map
 */
-(void) setProperties: (NSMutableDictionary<NSString *, NSObject *> *) properties;

/**
 * Get the simple feature
 *
 * @return simple feature
 */
-(SFGSimpleFeature *) feature;

/**
 * Get the simple feature geometry
 *
 * @return simple feature geometry
 */
-(SFGeometry *) simpleGeometry;

/**
 * Get the geometry type
 *
 * @return geometry type
 */
-(enum SFGeometryType) geometryType;

@end

