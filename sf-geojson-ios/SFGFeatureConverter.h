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

@interface SFGFeatureConverter : NSObject

+(NSMutableDictionary *) jsonToMutableTree: (NSString *) json;

+(NSDictionary *) jsonToTree: (NSString *) json;

+(NSString *) treeToJSON: (id) object;

+(SFGGeoJsonObject *) treeToObject: (NSDictionary *) tree;

+(SFGGeometry *) simpleGeometryToGeometry: (SFGeometry *) simpleGeometry;

@end
