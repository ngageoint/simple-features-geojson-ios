//
//  SFGSimpleFeature.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGSimpleFeature.h"

@implementation SFGSimpleFeature

-(instancetype) init{
    self = [super init];
    if(self != nil){
        self.properties = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(instancetype) initWithGeometry: (SFGeometry *) geometry andProperties: (NSMutableDictionary<NSString *, NSObject *> *) properties{
    self = [super init];
    if(self != nil){
        self.geometry = geometry;
        self.properties = properties;
    }
    return self;
}

@end
