//
//  MutableArrayThreadSafeTests.m
//  MutableArrayThreadSafeTests
//
//  Created by CPU12163 on 3/6/20.
//  Copyright © 2020 CPU12163. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>
#import "SafeMutableArray.h"

@interface MutableArrayThreadSafeTests : XCTestCase

@property (nonatomic) SafeMutableArray *mSafeArray;
@property (nonatomic) NSMutableArray *mMutableArray;
@property (nonatomic) NSMutableArray *mData;

@end

@implementation MutableArrayThreadSafeTests
@synthesize mSafeArray;
@synthesize mMutableArray;
@synthesize mData;

- (void)setUp {
    [super setUp];
    
    mSafeArray = [[SafeMutableArray alloc] init];
    mMutableArray = [[NSMutableArray alloc] init];
    mData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 1000; i++) {
        [mData addObject:[NSString stringWithFormat:@"%d", i]];
    }
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - TestAddObject

- (void)testAddObjectsOfSafeMutableArray {
    XCTAssertNoThrow(^{
        dispatch_apply(1000, DISPATCH_APPLY_AUTO, ^(size_t t){
            [self->mSafeArray addObject:[[NSNumber alloc] initWithInt:0]];
        });
    });
}

- (void)testAddObjectsOfNSMutableArray {
    dispatch_apply(1000, DISPATCH_APPLY_AUTO, ^(size_t t){
        [self->mMutableArray addObject:[[NSNumber alloc] initWithInt:0]];
    });
}

#pragma mark - TestRemoveAllObjects

- (void)testRemoveAllNSMutableArray {
    mMutableArray = [[NSMutableArray alloc] initWithArray:mData];
    
    XCTAssertNoThrow(^{
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            [self->mMutableArray removeAllObjects];
        });
        
        dispatch_async(queue, ^{
            [self->mMutableArray removeAllObjects];
        });
    });
}

- (void)testRemoveAllSafeMutableArray {
    mSafeArray = [[SafeMutableArray alloc] initWithArray:mData];
    
    XCTAssertNoThrow(^{
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            [self->mMutableArray removeAllObjects];
        });
        
        dispatch_async(queue, ^{
            [self->mMutableArray removeAllObjects];
        });
    });
}

#pragma mark - TestRemoveLastObject

- (void)testRemoveLastObjectNSMutableArray {
    mMutableArray = [[NSMutableArray alloc] initWithArray:mData];
    
    XCTAssertNoThrow(^{
        dispatch_apply(1000, DISPATCH_APPLY_AUTO, ^(size_t it){
            [self->mMutableArray removeLastObject];
        });
    });
    
    XCTAssertEqual(self->mMutableArray.count, 0);
}

- (void)testRemoveLastObjectSafeArray {
    mSafeArray = [[SafeMutableArray alloc] initWithArray:mData];
    
    XCTAssertNoThrow(^{
        dispatch_apply(1000, DISPATCH_APPLY_AUTO, ^(size_t it){
            [self->mSafeArray removeLastObject];
        });
    });
    
    XCTAssertEqual(self->mSafeArray.count, 0);
}

#pragma mark - TestRemoveObjectAtIndex

- (void)testRemoveObjectAtIndexNSMutableArray {
    mMutableArray = [[NSMutableArray alloc] initWithArray:mData];
    
    XCTAssertNoThrow(^{
        dispatch_apply(500, DISPATCH_APPLY_AUTO, ^(size_t it){
            [self->mMutableArray removeObjectAtIndex:10];
        });
    });
}

- (void)testRemoveObjectAtIndexSafeArray {
    mSafeArray = [[SafeMutableArray alloc] initWithArray:mData];
    
    XCTAssertNoThrow(^{
        dispatch_apply(20, DISPATCH_APPLY_AUTO, ^(size_t it){
            [self->mSafeArray removeObjectAtIndex:10];
        });
    });
}

#pragma mark - TestInsertObjectAtIndex

- (void)testInsertObjectAtIndexSafeArray {
    mSafeArray = [[SafeMutableArray alloc] initWithArray:mData];
    
    XCTAssertNoThrow(^{
        dispatch_apply(1000, DISPATCH_APPLY_AUTO, ^(size_t it){
            [self->mSafeArray insertObject:[[NSNumber alloc] initWithInt:0] atIndex:10];
        });
    });
}

- (void)testInsertObjectAtIndexNSMutableArray {
    mMutableArray = [[NSMutableArray alloc] initWithArray:mData];
    
    dispatch_apply(1000, DISPATCH_APPLY_AUTO, ^(size_t it){
        [self->mMutableArray insertObject:[[NSNumber alloc] initWithInt:0] atIndex:10];
    });
}

@end
