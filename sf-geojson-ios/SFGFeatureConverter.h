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
#import "SFGFeature.h"
#import "SFGFeatureCollection.h"

/**
 * Feature Converter
 */
@interface SFGFeatureConverter : NSObject

/**
 * Convert the string content to a feature
 *
 * @param content
 *            string content
 * @return feature
 */
+(SFGFeature *) jsonToFeature: (NSString *) json;

/**
 * Convert the JSON tree to a feature
 *
 * @param tree
 *            tree node
 * @return feature
 */
+(SFGFeature *) treeToFeature: (NSDictionary *) tree;

/**
 * Convert a simple geometry to a feature
 *
 * @param simpleGeometry
 *            simple geometry
 * @return feature
 */
+(SFGFeature *) simpleGeometryToFeature: (SFGeometry *) simpleGeometry;

/**
 * Convert the string content to a GeoJSON object
 *
 * @param content
 *            string content
 * @return GeoJSON object
 */
+(SFGGeoJSONObject *) jsonToObject: (NSString *) json;

/**
 * Convert the JSON tree to a GeoJSON Object
 *
 * @param tree
 *            JSON tree
 * @return GeoJSON object
 */
+(SFGGeoJSONObject *) treeToObject: (NSDictionary *) tree;

/**
 * Convert the object to a JSON value
 *
 * @param object
 *            object
 * @return string value
 */
+(NSString *) objectToJSON: (SFGGeoJSONObject *) object;

/**
 * Convert the simple geometry to a JSON value
 *
 * @param simpleGeometry
 *            simple geometry
 * @return string value
 */
+(NSString *) simpleGeometryToJSON: (SFGeometry *) simpleGeometry;

/**
 * Convert the JSON tree to a JSON string
 *
 * @param object
 *            JSON object
 * @return JSON string
 */
+(NSString *) treeToJSON: (id) object;

/**
 * Convert the GeoJSON object to a mutable tree
 *
 * @param object
 *            GeoJSON object
 * @return object map
 */
+(NSMutableDictionary *) objectToMutableTree: (SFGGeoJSONObject *) object;

/**
 * Convert the GeoJSON object to a tree
 *
 * @param object
 *            GeoJSON object
 * @return object map
 */
+(NSDictionary *) objectToTree: (SFGGeoJSONObject *) object;

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
 * Convert the simple geometry to a mutable tree
 *
 * @param simpleGeometry
 *            simple geometry
 * @return object map
 */
+(NSMutableDictionary *) simpleGeometryToMutableTree: (SFGeometry *) simpleGeometry;

/**
 * Convert the simple geometry to a tree
 *
 * @param simpleGeometry
 *            simple geometry
 * @return object map
 */
+(NSDictionary *) simpleGeometryToTree: (SFGeometry *) simpleGeometry;

/**
 * Convert the JSON tree to a geometry
 *
 * @param tree
 *            JSON tree
 * @return geometry
 */
+(SFGGeometry *) treeToGeometry: (NSDictionary *) tree;

/**
 * Convert the simple geometry to a geometry
 *
 * @param simpleGeometry
 *            simple geometry
 * @return geometry
 */
+(SFGGeometry *) simpleGeometryToGeometry: (SFGeometry *) simpleGeometry;

/**
 * Convert the JSON tree to a point
 *
 * @param tree
 *            JSON tree
 * @return point
 */
+(SFGPoint *) treeToPoint: (NSDictionary *) tree;

@end
