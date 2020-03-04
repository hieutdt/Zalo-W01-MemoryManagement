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
}

@end

@implementation SafeMutableArray
@synthesize count = mCount;

#pragma mark - Constructions

- (instancetype)init {
    self = [super init];
    if (self) {
        mArray = [[NSMutableArray alloc] init];
        mCount = mArray.count;
    }
    return self;
}

- (instancetype)initWithArray:(NSArray*)array {
    self = [super init];
    if (self) {
        dispatch_queue_t queue = dispatch_queue_create("init_array_queue", nullptr);
        dispatch_sync(queue, ^{
            mArray = [[NSMutableArray alloc] initWithArray:array];
            mCount = mArray.count;
        });
    }
    return self;
}

- (instancetype)initWithCapacity:(NSInteger)capacity {
    self = [super init];
    if (self) {
        dispatch_queue_t queue = dispatch_queue_create("init_array_queue", nullptr);
        dispatch_sync(queue,^{
            mArray = [[NSMutableArray alloc] initWithCapacity:capacity];
            mCount = mArray.count;
        });
    }
    return self;
}

- (instancetype)initWithContentsOfURL:(NSURL*)url {
    self = [super init];
    if (self) {
        dispatch_queue_t queue = dispatch_queue_create("init_array_queue", nullptr);
        dispatch_sync(queue, ^{
            mArray = [[NSMutableArray alloc] initWithContentsOfURL:url];
            mCount = mArray.count;
        });
    }
    return self;
}

- (instancetype)initWithContentsOfFile:(NSString*)path {
    self = [super init];
    if (self) {
        dispatch_queue_t queue = dispatch_queue_create("init_array_queue", nullptr);
        dispatch_sync(queue, ^{
            mArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
            mCount = mArray.count;
        });
    }
    return self;
}

#pragma mark - MutableArray methods

- (void)addObject:(id)object {
    if (object) {
        dispatch_queue_t queue = dispatch_queue_create("add_object_to_array_queue", nullptr);
        dispatch_sync(queue, ^{
            [mArray addObject:object];
            mCount = mArray.count;
        });
    }
}

- (id)objectAtIndex:(NSInteger)index {
    // This function cannot be synchonize
    if (index < mArray.count) {
        return [mArray objectAtIndex:index];
    }
    return nil;
}

@end
