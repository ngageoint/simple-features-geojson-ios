//
//  SFGGeometryTypes.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 10/26/21.
//  Copyright © 2021 NGA. All rights reserved.
//

@import sf_ios;

/**
 * Geometry Type enumeration
 */
typedef NS_ENUM(NSInteger, SFGGeometryType) {
    SFG_GEOMETRY = 0,
    SFG_POINT,
    SFG_LINESTRING,
    SFG_POLYGON,
    SFG_MULTIPOINT,
    SFG_MULTILINESTRING,
    SFG_MULTIPOLYGON,
    SFG_GEOMETRYCOLLECTION
};

/**
 * Geometry Types
 */
@interface SFGGeometryTypes : NSObject

/**
 * Get the type
 *
 * @return type
 */
-(SFGGeometryType) type;

/**
 * Get the simple geometry type
 *
 * @return simple geometry type
 */
-(SFGeometryType) simpleType;

/**
 * Get the name
 *
 * @return name
 */
-(NSString *) name;

/**
 *  Get the geometry type
 *
 *  @param geometryType geometry type enum
 *
 *  @return geometry type
 */
+(SFGGeometryTypes *) type: (SFGGeometryType) geometryType;

/**
 *  Get the geometry name
 *
 *  @param geometryType geometry type enum
 *
 *  @return geometry name
 */
+(NSString *) name: (SFGGeometryType) geometryType;

/**
 *  Get the geometry type of the name
 *
 *  @param name geometry type name
 *
 *  @return geometry type
 */
+(SFGGeometryTypes *) fromName: (NSString *) name;

@end
