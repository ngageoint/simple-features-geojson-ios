//
//  SFGOrderedDictionary.m
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

#import "SFGOrderedDictionary.h"

static NSString *DescriptionForObject(id object, id locale, NSUInteger indent)
{
    if ([object respondsToSelector:@selector(descriptionWithLocale:indent:)])
        return [object descriptionWithLocale:locale indent:indent];
    else if ([object respondsToSelector:@selector(descriptionWithLocale:)])
        return [object descriptionWithLocale:locale];
    return [object description];
}

@implementation SFGOrderedDictionary

- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        [self commonInitWithCapacity:0];
    }
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)capacity
{
    self = [super init];
    if (self != nil)
    {
        [self commonInitWithCapacity:capacity];
    }
    return self;
}

- (void)commonInitWithCapacity:(NSUInteger)capacity
{
    dictionary = [NSMutableDictionary dictionaryWithCapacity:capacity];
    array = [NSMutableArray arrayWithCapacity:capacity];
}

- (instancetype)copy
{
    return [self mutableCopy];
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (![dictionary objectForKey:aKey])
        [array addObject:aKey];
    [dictionary setObject:anObject forKey:aKey];
}

- (void)removeObjectForKey:(id)aKey
{
    [dictionary removeObjectForKey:aKey];
    [array removeObject:aKey];
}

- (NSUInteger)count
{
    return [dictionary count];
}

- (id)objectForKey:(id)aKey
{
    return [dictionary objectForKey:aKey];
}

- (NSEnumerator *)keyEnumerator
{
    return [array objectEnumerator];
}

- (NSEnumerator *)reverseKeyEnumerator
{
    return [array reverseObjectEnumerator];
}

- (void)insertObject:(id)anObject forKey:(id<NSCopying>)aKey atIndex:(NSUInteger)anIndex
{
    [array insertObject:aKey atIndex:anIndex];
    [dictionary setObject:anObject forKey:aKey];
}

- (id)keyAtIndex:(NSUInteger)anIndex
{
    return [array objectAtIndex:anIndex];
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
    return [self keyAtIndex:idx];
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx __attribute__((noreturn))
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Can't set indexed object on ordered dictionary" userInfo:nil];
}

- (id)objectForKeyedSubscript:(id)key
{
    return [self objectForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    [self setObject:obj forKey:key];
}

- (NSUInteger)indexOfKey:(id)anObject
{
    return [array indexOfObject:anObject];
}

- (NSUInteger)indexOfKey:(id)anObject inRange:(NSRange)range
{
    return [array indexOfObject:anObject inRange:range];
}

- (NSUInteger)indexOfKeyIdenticalTo:(id)anObject
{
    return [array indexOfObjectIdenticalTo:anObject];
}

- (NSUInteger)indexOfKeyIdenticalTo:(id)anObject inRange:(NSRange)range
{
    return [array indexOfObjectIdenticalTo:anObject inRange:range];
}

- (id)lastKey
{
    return [array lastObject];
}

- (void)sortUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context
{
    [array sortUsingFunction:compare context:context];
}

- (void)sortUsingSelector:(SEL)comparator
{
    [array sortUsingSelector:comparator];
}

#if NS_BLOCKS_AVAILABLE
- (void)sortUsingComparator:(NSComparator)cmptr
{
    [array sortUsingComparator:cmptr];
}

- (void)sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr
{
    [array sortWithOptions:opts usingComparator:cmptr];
}
#endif

- (NSString *)descriptionWithLocale:(id)locale
{
    return [self descriptionWithLocale:locale indent:0];
}

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *indentString = [NSMutableString string];
    
    for (NSUInteger i = 0; i < level; i++)
        [indentString appendString:@"\t"];
    
    NSMutableString *description = [NSMutableString stringWithFormat:@"%@{\n", indentString];
    
    for (id key in array)
    {
        [description appendFormat:@"%@\t%@ = %@;\n",
         indentString, DescriptionForObject(key, locale, level), DescriptionForObject(self[key], locale, level)];
    }
    [description appendFormat:@"%@}\n", indentString];
    return description;
}

@end
