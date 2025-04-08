//
//  SFGPosition.h
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/17/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SFPoint;

/**
 * Position
 */
@interface SFGPosition : NSObject

/**
 *  Coordinate values: long, lat, altitude, and additional elements such as m
 */
@property (nonatomic, strong) NSMutableArray<NSDecimalNumber *> *coordinates;

/**
 *  Create
 *
 *  @param point simple point
 *
 *  @return new position
 */
+(SFGPosition *) positionWithPoint: (SFPoint *) point;

/**
 *  Create
 *
 *  @param longitude longitude value
 *  @param latitude  latitude value
 *
 *  @return new position
 */
+(SFGPosition *) positionWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude;

/**
 *  Create
 *
 *  @param longitude           longitude value
 *  @param latitude            latitude value
 *
 *  @return new position
 */
+(SFGPosition *) positionWithLongitudeValue: (double) longitude andLatitudeValue: (double) latitude;

/**
 *  Create
 *
 *  @param longitude          longitude value
 *  @param latitude           latitude value
 *  @param altitude           altitude value
 *
 *  @return new position
 */
+(SFGPosition *) positionWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude andAltitude: (NSDecimalNumber *) altitude;

/**
 *  Create
 *
 *  @param longitude           longitude value
 *  @param latitude            latitude value
 *  @param altitude            altitude value
 *
 *  @return new position
 */
+(SFGPosition *) positionWithLongitudeValue: (double) longitude andLatitudeValue: (double) latitude andAltitudeValue: (double) altitude;

/**
 *  Create
 *
 *  @param longitude          longitude value
 *  @param latitude           latitude value
 *  @param altitude           altitude value
 *  @param additionalElement  additional value
 *
 *  @return new position
 */
+(SFGPosition *) positionWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude andAltitude: (NSDecimalNumber *) altitude andAdditional: (NSDecimalNumber *) additionalElement;

/**
 *  Create
 *
 *  @param longitude           longitude value
 *  @param latitude            latitude value
 *  @param altitude            altitude value
 *  @param additionalElement  additional value
 *
 *  @return new position
 */
+(SFGPosition *) positionWithLongitudeValue: (double) longitude andLatitudeValue: (double) latitude andAltitudeValue: (double) altitude andAdditionalValue: (double) additionalElement;

/**
 *  Create
 *
 *  @param longitude           longitude value
 *  @param latitude            latitude value
 *  @param altitude            altitude value
 *  @param additionalElements  additional values
 *
 *  @return new position
 */
+(SFGPosition *) positionWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude andAltitude: (NSDecimalNumber *) altitude andAdditionals: (NSArray<NSDecimalNumber *>*) additionalElements;

/**
 *  Create
 *
 *  @param longitude           longitude value
 *  @param latitude            latitude value
 *  @param altitude            altitude value
 *  @param additionalElements  additional values
 *
 *  @return new position
 */
+(SFGPosition *) positionWithLongitudeValue: (double) longitude andLatitudeValue: (double) latitude andAltitudeValue: (double) altitude andAdditionals: (NSArray<NSDecimalNumber *>*) additionalElements;

/**
 *  Create
 *
 *  @param coordinates  coordinates
 *
 *  @return new position
 */
+(SFGPosition *) positionWithCoordinates: (NSArray *) coordinates;

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
-(instancetype) initWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude;

/**
 *  Initialize
 *
 *  @param longitude           longitude value
 *  @param latitude            latitude value
 *
 *  @return new position
 */
-(instancetype) initWithLongitudeValue: (double) longitude andLatitudeValue: (double) latitude;

/**
 *  Initialize
 *
 *  @param longitude          longitude value
 *  @param latitude           latitude value
 *  @param altitude           altitude value
 *
 *  @return new position
 */
-(instancetype) initWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude andAltitude: (NSDecimalNumber *) altitude;

/**
 *  Initialize
 *
 *  @param longitude           longitude value
 *  @param latitude            latitude value
 *  @param altitude            altitude value
 *
 *  @return new position
 */
-(instancetype) initWithLongitudeValue: (double) longitude andLatitudeValue: (double) latitude andAltitudeValue: (double) altitude;

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
-(instancetype) initWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude andAltitude: (NSDecimalNumber *) altitude andAdditional: (NSDecimalNumber *) additionalElement;

/**
 *  Initialize
 *
 *  @param longitude           longitude value
 *  @param latitude            latitude value
 *  @param altitude            altitude value
 *  @param additionalElement  additional value
 *
 *  @return new position
 */
-(instancetype) initWithLongitudeValue: (double) longitude andLatitudeValue: (double) latitude andAltitudeValue: (double) altitude andAdditionalValue: (double) additionalElement;

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
-(instancetype) initWithLongitude: (NSDecimalNumber *) longitude andLatitude: (NSDecimalNumber *) latitude andAltitude: (NSDecimalNumber *) altitude andAdditionals: (NSArray<NSDecimalNumber *>*) additionalElements;

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
-(instancetype) initWithLongitudeValue: (double) longitude andLatitudeValue: (double) latitude andAltitudeValue: (double) altitude andAdditionals: (NSArray<NSDecimalNumber *>*) additionalElements;

/**
 *  Initialize
 *
 *  @param coordinates  coordinates
 *
 *  @return new position
 */
-(instancetype) initWithCoordinates: (NSArray *) coordinates;

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
