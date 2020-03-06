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
    NSMutableArray *mArray;
    SafeMutableArray *mSafeArray;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    mArray = [[NSMutableArray alloc] init];
    mSafeArray = [[SafeMutableArray alloc] init];
    
    dispatch_apply(1000, DISPATCH_APPLY_AUTO, ^(size_t t){
        [self->mSafeArray addObject:[NSString stringWithFormat:@"%d", (int)t]];
    });
    
    NSLog(@"Print array");
    for (int i = 0; i < mSafeArray.count; i++) {
        NSLog(@"%@", [mSafeArray objectAtIndex:i]);
    }
}

@end
