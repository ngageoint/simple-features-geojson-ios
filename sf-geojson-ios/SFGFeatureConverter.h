//
//  SFGFeatureConverter.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFGGeometry.h"
#import "SFGeometry.h"
#import "SFGPoint.h"

/**
 * Feature Converter
 */
@interface SFGFeatureConverter : NSObject

/**
 * Convert the JSON string to a mutable JSON tree
 *
 * @param json
 *            JSON string
 * @return tree
 */
+(NSMutableDictionary *) jsonToMutableTree: (NSString *) json;

/**
 * Convert the JSON string to a JSON tree
 *
 * @param json
 *            JSON string
 * @return tree
 */
+(NSDictionary *) jsonToTree: (NSString *) json;

/**
 * Convert the JSON tree to a JSON string
 *
 * @param object
 *            JSON object
 * @return JSON string
 */
+(NSString *) treeToJSON: (id) object;

/**
 * Convert the JSON tree to a GeoJSON Object
 *
 * @param tree
 *            JSON tree
 * @return GeoJSON object
 */
+(SFGGeoJSONObject *) treeToObject: (NSDictionary *) tree;

/**
 * Convert the JSON tree to a geometry
 *
 * @param tree
 *            JSON tree
 * @return geometry
 */
+(SFGGeometry *) treeToGeometry: (NSDictionary *) tree;

/**
 * Convert the JSON tree to a point
 *
 * @param tree
 *            JSON tree
 * @return point
 */
+(SFGPoint *) treeToPoint: (NSDictionary *) tree;

/**
 * Convert the simple geometry to a geometry
 *
 * @param simpleGeometry
 *            simple geometry
 * @return geometry
 */
+(SFGGeometry *) simpleGeometryToGeometry: (SFGeometry *) simpleGeometry;

@end
