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
    __block id obj;
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(concurrentQueue, ^{
        obj = [mArray objectAtIndex:index];
    });
    
    return obj;
}

- (void)removeAllObjects {
    dispatch_queue_t queue = dispatch_queue_create("remove_all_objects_queue", nullptr);
    dispatch_sync(queue, ^{
        [mArray removeAllObjects];
        mCount = mArray.count;
    });
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    dispatch_queue_t queue = dispatch_queue_create("insert_obj_at_index", nullptr);
    dispatch_sync(queue, ^{
        [mArray insertObject:anObject atIndex:index];
        mCount = mArray.count;
    });
}
 


@end
