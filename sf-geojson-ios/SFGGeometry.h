//
//  SFGGeometry.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGGeoJsonObject.h"
#import "SFGeometry.h"

/**
 * Geometry
 */
@interface SFGGeometry : SFGGeoJsonObject

/**
 * Get the simple geometry
 *
 * @return simple geometry
 */
-(SFGeometry *) geometry;

/**
 * Get the JSON object coordinates
 *
 * @return coordinates
 */
-(NSObject *) coordinates;

@end
