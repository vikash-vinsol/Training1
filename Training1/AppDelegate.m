//
//  AppDelegate.m
//  Training1
//
//  Created by Vikash Soni on 10/06/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "AppDelegate.h"
#import "Product.h"
#import "Filter.h"

@interface AppDelegate ()

{
    Filter *brandFilter;
    Filter *colorFilter;
}

@end

@implementation AppDelegate
@synthesize parsedArray,productsArray,productArray,brandArray,colorArray;
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"product" ofType:@"json"];
    NSError * error=nil;
    
    NSString *jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    parsedArray = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    brandArray         = [[NSMutableArray alloc] init];
    colorArray         = [[NSMutableArray alloc] init];
    productArray       = [[NSMutableArray alloc] init];
    productsArray      = [[NSMutableArray alloc] init];
    brandFilter =           [[Filter alloc] init];
    colorFilter = [[Filter alloc] init];
    
    return YES;
}

-(NSMutableArray *) getProductData
{
    for(NSDictionary *dictObj in parsedArray)
    {
        Product *product = [[Product alloc] init];
        product.brand = dictObj[@"brand"];
        
        [brandFilter addValue:product.brand];
        
        product.color = dictObj[@"color"];
        
        [colorFilter addValue:product.color];
                
        product.available = dictObj[@"sold_out"];
        product.imageURL  = dictObj[@"url"];
        
        product.visible = true;
        [productArray addObject:product];
        
        NSLog(@"color %@",colorFilter);
        NSLog(@"brand %@",brandFilter);
    }
    
    productsArray = [NSMutableArray arrayWithObjects:productArray, brandArray, colorArray, nil];
        
    return productsArray;
}

@end
