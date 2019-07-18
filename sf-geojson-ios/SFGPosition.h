//
//  SFGPosition.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFPoint.h"

/**
 * Position
 */
@interface SFGPosition : NSObject

/**
 *  Initialize
 *
 *  @param point simple point
 *
 *  @return new position
 */
-(instancetype) initWithPoint: (SFPoint *) point;

/**
 *  Initialize
 *
 *  @param longitude longitude value
 *  @param latitude  latitude value
 *
 *  @return new position
 */
-(instancetype) initWithLongitude: (NSNumber *) longitude andLatitude: (NSNumber *) latitude;

/**
 *  Initialize
 *
 *  @param longitude          longitude value
 *  @param latitude           latitude value
 *  @param altitude           altitude value
 *
 *  @return new position
 */
-(instancetype) initWithLongitude: (NSNumber *) longitude andLatitude: (NSNumber *) latitude andAltitude: (NSNumber *) altitude;

/**
 *  Initialize
 *
 *  @param longitude          longitude value
 *  @param latitude           latitude value
 *  @param altitude           altitude value
 *  @param additionalElement  additional value
 *
 *  @return new position
 */
-(instancetype) initWithLongitude: (NSNumber *) longitude andLatitude: (NSNumber *) latitude andAltitude: (NSNumber *) altitude andAdditional: (NSNumber *) additionalElement;

/**
 *  Initialize
 *
 *  @param longitude           longitude value
 *  @param latitude            latitude value
 *  @param altitude            altitude value
 *  @param additionalElements  additional values
 *
 *  @return new position
 */
-(instancetype) initWithLongitude: (NSNumber *) longitude andLatitude: (NSNumber *) latitude andAltitude: (NSNumber *) altitude andAdditionals: (NSArray<NSNumber *>*) additionalElements;

/**
 * Get the coordinaes
 *
 * @return coordinates
 */
-(NSArray<NSDecimalNumber *> *) coordinates;

/**
 * Check if the position has additional elements
 *
 * @return true if additional elements
 */
-(BOOL) hasAdditionalElements;

/**
 * Get the additional elements
 *
 * @return additional elements
 */
-(NSArray<NSDecimalNumber *> *) additionalElements;
  
/**
* Get the x value
*
* @return x
*/
-(NSDecimalNumber *) x;
  
/**
* Get the y value
*
* @return y
*/
-(NSDecimalNumber *) y;
  
/**
* Get the z value
*
* @return z
*/
-(NSDecimalNumber *) z;
  
/**
* Get the m value
*
* @return m
*/
-(NSDecimalNumber *) m;
  
/**
* Check if position has a z value
*
* @return true if has z value
*/
-(BOOL) hasZ;
  
/**
* Check if position has a m value
*
* @return true if has m value
*/
-(BOOL) hasM;
  
/**
* Convert to simple point
*
* @return simple point
*/
-(SFPoint *) toSimplePoint;
  
@end
