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
@synthesize parsedArray,finalArray,productArray,brandArray,colorArray;
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"product" ofType:@"json"];
    NSError * error=nil;
    
    NSString *jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    parsedArray = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    return YES;
}

-(NSMutableArray *) getProductData
{
    brandArray         = [[NSMutableArray alloc] init];
    colorArray         = [[NSMutableArray alloc] init];
    productArray       = [[NSMutableArray alloc] init];
    finalArray         = [[NSMutableArray alloc] init];

    for(NSDictionary *dictObj in parsedArray)
    {
        Product *product   = [[Product alloc] init];
        product.brand = dictObj[@"brand"];
        
        [self createFilterArray:brandArray :product.brand];
        product.color = dictObj[@"color"];
        
        [self createFilterArray:colorArray :product.color];
        product.available = dictObj[@"sold_out"];
        product.imageURL  = dictObj[@"url"];
        
        product.visible = true;
        [productArray addObject:product];
    }
    
    finalArray = [[NSMutableArray alloc] initWithObjects:productArray,brandArray,colorArray, nil];
        
    return finalArray;
}

-(void)createFilterArray:(NSMutableArray *)Filteredarray : (NSString *)filterType
{
    if (! [Filteredarray containsObject:filterType])
    {
        [Filteredarray addObject:filterType];
    }
}
@end
