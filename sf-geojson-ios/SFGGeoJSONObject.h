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
 * GeoJSON Object
 */
@interface SFGGeoJSONObject : NSObject

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
 * Get the type of the JSON tree
 *
 * @return type
 */
+(NSString *) treeType: (NSDictionary *) tree;

@end
