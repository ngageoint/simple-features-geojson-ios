//
//  SFGSimpleFeature.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFGeometry.h"

/**
 * The simple feature
 */
@interface SFGSimpleFeature : NSObject

/**
 * Geometry
 */
@property (nonatomic, strong) SFGeometry *geometry;

/**
 * Properties dictionary
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSObject *> *properties;

/**
 *  Initialize
 *
 *  @return new simple feature
 */
-(instancetype) init;

/**
 *  Initialize
 *
 *  @param geometry geometry
 *
 *  @return new simple feature
 */
-(instancetype) initWithGeometry: (SFGeometry *) geometry andProperties: (NSMutableDictionary<NSString *, NSObject *> *) properties;

@end
