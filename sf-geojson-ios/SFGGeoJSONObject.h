//
//  SFGGeoJSONObject.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Type key
 */
extern NSString * const SFG_TYPE;

/**
 * Bounding Box key
 */
extern NSString * const SFG_BBOX;

/**
 * GeoJSON Object
 */
@interface SFGGeoJSONObject : NSObject

/**
 *  Bounding box
 */
@property (nonatomic, strong) NSMutableArray<NSDecimalNumber *> *bbox;

/**
 *  Foreign members
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSObject *> *foreignMembers;

/**
 *  Initialize
 *
 *  @return new object
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param tree JSON tree
 *
 *  @return new object
 */
-(instancetype) initWithTree: (NSDictionary *) tree;

/**
 * Get the GeoJSON object type
 *
 * @return GeoJSON object type
 */
-(NSString *) type;

/**
 * Convert to a JSON tree
 *
 * @return JSON tree
 */
-(NSMutableDictionary *) toTree;

/**
 * Set from a JSON tree
 *
 * @param tree JSON tree
 */
-(void) fromTree: (NSDictionary *) tree;

/**
 * Get the JSON keys
 *
 * @return JSON keys
 */
-(NSOrderedSet<NSString *> *) keys;

/**
 * Get the type of the JSON tree
 *
 * @return type
 */
+(NSString *) treeType: (NSDictionary *) tree;

@end
