//
//  SafeMutableArray.h
//  Zalo-W01-Memory Management
//
//  Created by CPU12163 on 3/4/20.
//  Copyright © 2020 CPU12163. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SafeMutableArray : NSObject

- (instancetype)initWithArray:(NSArray*)array;
- (instancetype)initWithCapacity:(NSInteger)capacity;
- (instancetype)initWithContentsOfURL:(NSURL*)url;
- (instancetype)initWithContentsOfFile:(NSString*)path;

- (void)addObject:(id)object;
- (id)objectAtIndex:(NSInteger)index;
- (void)removeAllObjects;
- (void)removeObjectAtIndex:(NSInteger)index;
- (void)removeObject:(id)anObject inRange:(NSRange)range;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
- (unsigned long)count;

@end

NS_ASSUME_NONNULL_END
