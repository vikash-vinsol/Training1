//
//  AppDelegate.m
//  Training1
//
//  Created by Vikash Soni on 10/06/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "AppDelegate.h"
#import "Product.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize parsedArray,productArray;
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"product" ofType:@"json"];
    NSError * error    = nil;
    
    NSString *jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSData * jsonData    = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    parsedArray          = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];

    productArray     = [[NSMutableArray alloc] init];
    _brandFilter     = [[Filter alloc] initWithName: @"brand"];
    _colorFilter     = [[Filter alloc] initWithName: @"color"];
    
    return YES;
}

-(NSMutableArray *) getProductData
{
    for(NSDictionary *dictObj in parsedArray)
    {
        Product *product = [[Product alloc] init];

        product.brand = dictObj[@"brand"];
        [_brandFilter addValue:product.brand];
        
        product.color = dictObj[@"color"];
        [_colorFilter addValue:product.color];
                
        product.available = dictObj[@"sold_out"];
        product.imageURL  = dictObj[@"url"];
        
        product.visible = true;
        [productArray addObject:product];
    }
        
    return productArray;
}

@end
