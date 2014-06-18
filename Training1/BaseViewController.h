//
//  BaseViewController.h
//  Training1
//
//  Created by Vikash Soni on 11/06/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Product.h"


@interface BaseViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *receivedArray;
@property (nonatomic, strong) NSArray *productsListArray;
@property (nonatomic, strong) NSArray *brandFilterArray;
@property (nonatomic, strong) NSArray *colorFilterArray;
@property (nonatomic, strong) Product *product;

- (IBAction)filterAction:(id)sender;

@end
