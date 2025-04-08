//
//  SFGOrderedDictionary.h
//  SFGOrderedDictionary
//
//  Created by Matt Gallagher on 19/12/08.
//    Modified by Gwynne Raskind on 31/12/12.
//  Copyright 2008 Matt Gallagher. All rights reserved.
//    Parts Copyright 2012 Gwynne Raskind. All rights reserved.
//
//  This software is provided 'as-is', without any express or implied
//  warranty. In no event will the authors be held liable for any damages
//  arising from the use of this software. Permission is granted to anyone to
//  use this software for any purpose, including commercial applications, and to
//  alter it and redistribute it freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source
//     distribution.
//

#import <Foundation/Foundation.h>

@interface SFGOrderedDictionary : NSMutableDictionary
{
    NSMutableDictionary *dictionary;
    NSMutableArray *array;
}

- (void)insertObject:(id)anObject forKey:(id<NSCopying>)aKey atIndex:(NSUInteger)anIndex;
- (id)keyAtIndex:(NSUInteger)anIndex;
- (NSEnumerator *)reverseKeyEnumerator;

- (id)objectAtIndexedSubscript:(NSUInteger)idx;

- (id)objectForKeyedSubscript:(id)key;
- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key;

- (NSUInteger)indexOfKey:(id)anObject;
- (NSUInteger)indexOfKey:(id)anObject inRange:(NSRange)range;
- (NSUInteger)indexOfKeyIdenticalTo:(id)anObject;
- (NSUInteger)indexOfKeyIdenticalTo:(id)anObject inRange:(NSRange)range;
- (id)lastKey;

- (void)sortUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context;
- (void)sortUsingSelector:(SEL)comparator;
#if NS_BLOCKS_AVAILABLE
- (void)sortUsingComparator:(NSComparator)cmptr;
- (void)sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;
#endif

@end
