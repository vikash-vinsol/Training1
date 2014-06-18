//
//  BaseCollectionViewCell.h
//  Training1
//
//  Created by Vikash Soni on 11/06/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *availableLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;

@end
