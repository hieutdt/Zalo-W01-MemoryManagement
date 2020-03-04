//
//  MainViewController.m
//  Zalo-W01-Memory Management
//
//  Created by CPU12163 on 3/4/20.
//  Copyright © 2020 CPU12163. All rights reserved.
//

#import "MainViewController.h"
#import "SafeMutableArray.h"

@interface MainViewController () {
    __weak IBOutlet UIStackView *mStackView;
    
    NSMutableArray *mArray;
    SafeMutableArray *mSafeArray;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mArray = [[NSMutableArray alloc] init];
    mSafeArray = [[SafeMutableArray alloc] init];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
            NSLog(@"Add the first %d", i);
//            [self->mArray addObject:[NSString stringWithFormat:@"%d", i]];
            [self->mSafeArray addObject:[NSString stringWithFormat:@"%d", i]];
        });
        
        dispatch_async(queue, ^{
            NSLog(@"Remove the first %d", i);
//            [self->mArray removeObjectAtIndex:i];
        });
    }
}


@end
