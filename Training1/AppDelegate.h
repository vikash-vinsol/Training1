//
//  AppDelegate.h
//  Training1
//
//  Created by Vikash Soni on 10/06/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Filter.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong , nonatomic) NSMutableArray *parsedArray;
@property (strong , nonatomic) NSMutableArray *productArray;
@property (strong , nonatomic) Filter *brandFilter;
@property (strong , nonatomic) Filter *colorFilter;




-(NSMutableArray *) getProductData;

@end

