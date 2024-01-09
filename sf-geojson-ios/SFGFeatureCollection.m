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

NSString * const SFG_MEMBER_FEATURES = @"features";

static NSOrderedSet *keys = nil;

@implementation SFGFeatureCollection

+(void) initialize{
    if(keys == nil){
        keys = [NSOrderedSet orderedSetWithObjects:SFG_MEMBER_TYPE, SFG_MEMBER_BBOX, SFG_MEMBER_FEATURES, nil];
    }
}

+(SFGFeatureCollection *) featureCollection{
    return [[SFGFeatureCollection alloc] init];
}

+(SFGFeatureCollection *) featureCollectionWithFeature: (SFGFeature *) feature{
    return [[SFGFeatureCollection alloc] initWithFeature:feature];
}

+(SFGFeatureCollection *) featureCollectionWithFeatures: (NSArray<SFGFeature *> *) features{
    return [[SFGFeatureCollection alloc] initWithFeatures:features];
}

+(SFGFeatureCollection *) featureCollectionWithTree: (NSDictionary *) tree{
    return [[SFGFeatureCollection alloc] initWithTree:tree];
}

-(instancetype) init{
    self = [super init];
    if(self != nil){
        self.features = [NSMutableArray array];
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

-(SFGeometry *) simpleGeometry{
    SFGeometry *geometry = nil;
    if(_features != nil && _features.count > 0){
        SFGeometryCollection *geomCollection = [SFGeometryCollection geometryCollection];
        for(SFGFeature *feature in _features){
            SFGeometry *geom = [feature simpleGeometry];
            if(geom != nil){
                [geomCollection addGeometry:geom];
            }
        }
        if(![geomCollection isEmpty]){
            geometry = geomCollection;
        }
    }
    return geometry;
}

-(enum SFGGeometryType) geometryType{
    enum SFGGeometryType result = -1;
    
    for(SFGFeature *feature in self.features){
        enum SFGGeometryType gt = [feature geometryType];
        if(result == -1){
            result = gt;
        }else if(gt != result){
            result = SFG_GEOMETRY;
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
    NSMutableArray *features = [NSMutableArray array];
    for(SFGFeature *feature in self.features){
        [features addObject:[feature toTree]];
    }
    [tree setObject:features forKey:SFG_MEMBER_FEATURES];
    return tree;
}

-(void) fromTree: (NSDictionary *) tree{
    [super fromTree:tree];
    self.features = [NSMutableArray array];
    NSArray *featuresArray = [tree objectForKey:SFG_MEMBER_FEATURES];
    if(![featuresArray isEqual:[NSNull null]] && featuresArray != nil){
        for(NSDictionary *featureTree in featuresArray){
            [self.features addObject:[SFGFeatureConverter treeToFeature:featureTree]];
        }
    }
}

-(NSOrderedSet<NSString *> *) keys{
    return keys;
}

-(BOOL) isEqualToFeatureCollection: (SFGFeatureCollection *) featureCollection{
    if (self == featureCollection)
        return YES;
    if (featureCollection == nil)
        return NO;
    if (![super isEqual:featureCollection])
        return NO;
    if (self.features == nil) {
        if (featureCollection.features != nil)
            return NO;
    } else if (![self.features isEqual:featureCollection.features])
        return NO;
    return YES;
}

-(BOOL) isEqual: (id) object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SFGFeatureCollection class]]) {
        return NO;
    }
    
    return [self isEqualToFeatureCollection:(SFGFeatureCollection *)object];
}

-(NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = [super hash];
    result = prime * result
        + ((self.features == nil) ? 0 : [self.features hash]);
    return result;
}

@end
