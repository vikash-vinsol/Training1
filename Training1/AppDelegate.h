//
//  AppDelegate.h
//  Training1
//
//  Created by Vikash Soni on 10/06/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong , nonatomic) NSMutableArray *productsArray;
@property (strong , nonatomic) NSMutableArray *parsedArray;
@property (strong , nonatomic) NSMutableArray *productArray;
@property (nonatomic , strong) NSMutableArray *brandArray;
@property (nonatomic , strong) NSMutableArray *colorArray;

-(NSMutableArray *) getProductData;

@end

