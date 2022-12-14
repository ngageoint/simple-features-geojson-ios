//
//  SFGFeature.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeometry.h"

/**
 * Feature type
 */
extern NSString * const SFG_TYPE_FEATURE;

/**
 * Id key
 */
extern NSString * const SFG_MEMBER_ID;

/**
 * Geometry key
 */
extern NSString * const SFG_MEMBER_GEOMETRY;

/**
 * Properties key
 */
extern NSString * const SFG_MEMBER_PROPERTIES;

/**
 * Feature
 */
@interface SFGFeature : SFGGeoJSONObject

/**
 *  Feature id
 */
@property (nonatomic, strong) NSString *id;

/**
 * Geometry
 */
@property (nonatomic, strong) SFGGeometry *geometry;

/**
 * Properties dictionary
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSObject *> *properties;

/**
 *  Create
 *
 *  @return new feature
 */
+(SFGFeature *) feature;

/**
 *  Create
 *
 *  @param geometry geometry
 *
 *  @return new feature
 */
+(SFGFeature *) featureWithGeometry: (SFGGeometry *) geometry;

/**
 *  Create
 *
 *  @param tree JSON tree
 *
 *  @return new feature
 */
+(SFGFeature *) featureWithTree: (NSDictionary *) tree;

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
-(enum SFGGeometryType) geometryType;

@end

