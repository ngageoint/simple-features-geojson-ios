//
//  SFGFeatureCollection.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeoJSONObject.h"
#import "SFGFeature.h"

/**
 * Feature Collection type
 */
extern NSString * const SFG_TYPE_FEATURE_COLLECTION;

/**
 * Features key
 */
extern NSString * const SFG_FEATURES;

/**
 * Feature Collection
 */
@interface SFGFeatureCollection : SFGGeoJSONObject

/**
 *  Collection of features
 */
@property (nonatomic, strong) NSMutableArray<SFGFeature *> *features;

/**
 *  Initialize
 *
 *  @return new feature collection
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param feature feature
 *
 *  @return new feature collection
 */
-(instancetype) initWithFeature: (SFGFeature *) feature;

/**
 *  Initialize
 *
 *  @param features array of features
 *
 *  @return new feature collection
 */
-(instancetype) initWithFeatures: (NSArray<SFGFeature *> *) features;

/**
 *  Initialize
 *
 *  @param tree JSON tree
 *
 *  @return new feature
 */
-(instancetype) initWithTree: (NSDictionary *) tree;

/**
 * Add a feature
 *
 * @param feature
 *            feature
 */
-(void) addFeature: (SFGFeature *) feature;

/**
 * Add the features
 *
 * @param features
 *            collection of features
 */
-(void) addFeatures: (NSArray<SFGFeature *> *) features;

/**
 * Get the number of features
 *
 * @return feature count
 */
-(int) numFeatures;

/**
 * Get the feature at the index
 *
 * @param index
 *            index
 * @return feature
 */
-(SFGFeature *) featureAtIndex: (int) index;

/**
 * Get the geometry type
 *
 * @return geometry type
 */
-(enum SFGeometryType) geometryType;

/**
 * Get the combined properties from all features
 *
 * @return properties
 */
-(NSDictionary<NSString *, NSString *> *) properties;

@end
