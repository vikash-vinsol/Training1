//
//  Product.h
//  Training1
//
//  Created by Vikash Soni on 11/06/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
{
}

@property (nonatomic,strong) NSString * brand;
@property (nonatomic,strong) NSString * color;
@property (nonatomic,strong) NSString * imageURL;
@property (nonatomic,strong) NSString * available;
@property (assign) BOOL      visible;

@end
