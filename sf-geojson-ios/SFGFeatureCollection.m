//
//  SFGFeatureCollection.m
//  sf-geojson-ios
//
//  Created by Brian Osborn on 7/22/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import "SFGFeatureCollection.h"
#import "SFGFeatureConverter.h"
#import "SFGOrderedDictionary.h"

NSString * const SFG_TYPE_FEATURE_COLLECTION = @"FeatureCollection";

NSString * const SFG_FEATURES = @"features";

@implementation SFGFeatureCollection

-(instancetype) init{
    self = [super init];
    if(self != nil){
        self.features = [[NSMutableArray alloc] init];
    }
    return self;
}

-(instancetype) initWithFeature: (SFGFeature *) feature{
    self = [self init];
    if(self != nil){
        [self addFeature:feature];
    }
    return self;
}

-(instancetype) initWithFeatures: (NSArray<SFGFeature *> *) features{
    self = [self init];
    if(self != nil){
        [self setFeatures:[features mutableCopy]];
    }
    return self;
}

-(instancetype) initWithTree: (NSDictionary *) tree{
    self = [super initWithTree:tree];
    return self;
}

-(void) addFeature: (SFGFeature *) feature{
    [self.features addObject:feature];
}

-(void) addFeatures: (NSArray<SFGFeature *> *) features{
    [self.features addObjectsFromArray:features];
}

-(int) numFeatures{
    return (int) self.features.count;
}

-(SFGFeature *) featureAtIndex: (int) index{
    return [self.features objectAtIndex:index];
}

-(enum SFGeometryType) geometryType{
    enum SFGeometryType result = SF_NONE;
    
    for(SFGFeature *feature in self.features){
        enum SFGeometryType gt = [feature geometryType];
        if(result == SF_NONE){
            result = gt;
        }else if(gt != result){
            result = SF_GEOMETRY;
            break;
        }
    }
    
    return result;
}

-(NSDictionary<NSString *, NSObject *> *) properties{
    NSMutableDictionary<NSString *, NSObject *> *result = [[SFGOrderedDictionary alloc] init];
    for(SFGFeature *feature in self.features){
        NSMutableDictionary<NSString *, NSObject *> *properties = [feature properties];
        for(NSString *property in [properties allKeys]){
            if([result objectForKey:property] == nil){
                [result setObject:[properties objectForKey:property] forKey:property];
            }
        }
    }
    return result;
}

-(NSString *) type{
    return SFG_TYPE_FEATURE_COLLECTION;
}

-(NSMutableDictionary *) toTree{
    NSMutableDictionary *tree = [super toTree];
    NSMutableArray *features = [[NSMutableArray alloc] init];
    for(SFGFeature *feature in self.features){
        [features addObject:[feature toTree]];
    }
    [tree setObject:features forKey:SFG_FEATURES];
    return tree;
}

-(void) fromTree: (NSDictionary *) tree{
    [super fromTree:tree];
    self.features = [[NSMutableArray alloc] init];
    NSArray *featuresArray = [tree objectForKey:SFG_FEATURES];
    if(![featuresArray isEqual:[NSNull null]] && featuresArray != nil){
        for(NSDictionary *featureTree in featuresArray){
            [self.features addObject:[SFGFeatureConverter treeToFeature:featureTree]];
        }
    }
}

@end
