//
//  SafeMutableArray.m
//  Zalo-W01-Memory Management
//
//  Created by CPU12163 on 3/4/20.
//  Copyright © 2020 CPU12163. All rights reserved.
//

#import "SafeMutableArray.h"

@interface SafeMutableArray() {
    NSMutableArray *mArray;
    dispatch_queue_t mSyncQueue;
}

@end

@implementation SafeMutableArray

#pragma mark - Constructions

- (instancetype)init {
    self = [super init];
    if (self) {
        mArray = [[NSMutableArray alloc] init];
        mSyncQueue = dispatch_queue_create("SafeMutableArrayQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (instancetype)initWithArray:(NSArray*)array {
    self = [super init];
    if (self) {
        mSyncQueue = dispatch_queue_create("SafeMutableArrayQueue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_barrier_async(mSyncQueue, ^{
            self->mArray = [[NSMutableArray alloc] initWithArray:array];
        });
    }
    return self;
}

- (instancetype)initWithCapacity:(NSInteger)capacity {
    self = [super init];
    if (self) {
        mSyncQueue = dispatch_queue_create("SafeMutableArrayQueue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_barrier_async(mSyncQueue, ^{
            self->mArray = [[NSMutableArray alloc] initWithCapacity:capacity];
        });
    }
    return self;
}

- (instancetype)initWithContentsOfURL:(NSURL*)url {
    self = [super init];
    if (self) {
        mSyncQueue = dispatch_queue_create("SafeMutableArrayQueue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_barrier_async(mSyncQueue, ^{
            self->mArray = [[NSMutableArray alloc] initWithContentsOfURL:url];
        });
    }
    return self;
}

- (instancetype)initWithContentsOfFile:(NSString*)path {
    self = [super init];
    if (self) {
        mSyncQueue = dispatch_queue_create("SafeMutableArrayQueue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_barrier_async(mSyncQueue, ^{
            self->mArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
        });
    }
    return self;
}

#pragma mark - MutableArray methods

- (void)addObject:(id)object {
    if (object) {
        dispatch_barrier_async(mSyncQueue, ^{
            [self->mArray addObject:object];
        });
    }
}

- (id)objectAtIndex:(NSInteger)index {
    __block id obj;
    dispatch_sync(mSyncQueue, ^{
        unsigned long count = mArray.count;
        obj = index < count ? [mArray objectAtIndex:index] : nil;
    });
    
    return obj;
}

- (void)removeAllObjects {
    dispatch_barrier_async(mSyncQueue, ^{
        [self->mArray removeAllObjects];
    });
}

- (void)removeObjectAtIndex:(NSInteger)index {
    dispatch_barrier_async(mSyncQueue, ^{
        unsigned long count = self->mArray.count;
        if (index < count) {
            [self->mArray removeObjectAtIndex:index];
        }
    });
}

- (void)removeLastObject {
    dispatch_barrier_async(mSyncQueue, ^{
        [self->mArray removeLastObject];
    });
}

- (void)removeObject:(id)anObject inRange:(NSRange)range {
    dispatch_barrier_async(mSyncQueue, ^{
        if (!anObject)
            return;
        
        [self->mArray removeObject:anObject inRange:range];
    });
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    dispatch_barrier_async(mSyncQueue, ^{
        unsigned long count = self->mArray.count;
        if (!anObject)
            return;
        
        if (index >= count)
            return;
        
        [self->mArray replaceObjectAtIndex:index withObject:anObject];
    });
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    dispatch_barrier_async(mSyncQueue, ^{
        if (!anObject)
            return;
        
        if (index < self->mArray.count) {
            [self->mArray insertObject:anObject atIndex:index];
        }
    });
}

- (unsigned long)count {
    __block unsigned long count = 0;
    dispatch_sync(mSyncQueue, ^{
        count = mArray.count;
    });
    return count;
}

#pragma mark - Wrapper methods

- (instancetype)initWithMutableArray:(NSMutableArray*)mutableArray {
    self = [super init];
    if (self)  {
        mSyncQueue = dispatch_queue_create("SafeMutableArrayQueue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_barrier_async(mSyncQueue, ^{
            self->mArray = [NSMutableArray arrayWithArray:mutableArray];
        });
    }
    return self;
}

- (NSMutableArray*)mutableArray {
    __block NSMutableArray *array;
    dispatch_sync(mSyncQueue, ^{
        array = mArray;
    });
    return array;
}

@end
