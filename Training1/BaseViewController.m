//
//  BaseViewController.m
//  Training1
//
//  Created by Vikash Soni on 11/06/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseCollectionViewCell.h"
#import "FPPopoverController.h"
#import "BrandTableViewController.h"
#import "ColorTableViewController.h"
#import "AvailableTableViewController.h"
#import "FilterTableViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
{
    NSMutableArray *filteredBrand;
    NSMutableArray *filteredColor;
    NSMutableArray *filteredAvail;
    FilterTableViewController *filterViewController;
    FPPopoverController *popOver;
    UIButton *button;
}

@synthesize receivedArray,brandFilterArray,colorFilterArray,productsListArray,product;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    product = [[Product alloc] init];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    receivedArray = [appDelegate getProductData];
    
    brandFilterArray = [[NSArray alloc] initWithObjects:[receivedArray objectAtIndex:2], nil];
    colorFilterArray = [[NSArray alloc] initWithObjects:[receivedArray objectAtIndex:1], nil];
    productsListArray = [receivedArray objectAtIndex:0];
    
    filteredBrand = [[NSMutableArray alloc] init];
    filteredColor = [[NSMutableArray alloc] init];
    filteredAvail = [[NSMutableArray alloc] init];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveFilterUpdate:) name:@"FilterChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveColorUpdate:) name:@"colorFilterChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveAvailUpdate:) name:@"availFilterChanged" object:nil];
}

#pragma mark Notification Methods

- (void)recieveBrandUpdate:(NSNotification *)notification
{
    filteredBrand = [[notification userInfo ] objectForKey:@"brand"] ;
    [self filterVisibilityOfProduct ];
}

- (void)recieveColorUpdate:(NSNotification *)notification
{
    filteredColor = [[notification userInfo] objectForKey:@"color"];
    
    [self filterVisibilityOfProduct ];
}

- (void)recieveAvailUpdate:(NSNotification *)notification
{
    filteredAvail = [[notification userInfo] objectForKey:@"avail"];
    [self filterVisibilityOfProduct];
}

- (void)recieveFilterUpdate:(NSNotification *)notification
{
    if (button.tag == 1)
    {
        filteredBrand = [[notification userInfo] objectForKey:@"Filters"];
    }
    
    else if ( button.tag == 2)
    {
        filteredColor = [[notification userInfo] objectForKey:@"Filters"];
    }
    
    else if ( button.tag == 3)
    {
        filteredAvail = [[notification userInfo] objectForKey:@"Filters"];
    }
    
    [self filterVisibilityOfProduct];
}

-(void)filterVisibilityOfProduct
{
    for (int i=0; i<[productsListArray count]; i++)
    {
        product = [[Product alloc] init];
        product = [productsListArray objectAtIndex:i];
        
        if (filteredBrand.count == 0 && filteredColor.count == 0 && filteredAvail.count == 0)
            {
                product.visible = true;
            }
        
        else
        {
            if (((filteredBrand.count == 0) || [filteredBrand containsObject:product.brand]) &&
                ((filteredColor.count == 0) || [filteredColor containsObject:product.color]) &&
                ((filteredAvail.count == 0) || [filteredAvail containsObject:product.available]))
                {
                    product.visible = true;
                }
          	
            else
                {
                    product.visible = false;
                }
        }
    }
    [self.collectionView reloadData];
}

#pragma mark collectionview_datasource_methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return [productsListArray  count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Base_Cell" forIndexPath:indexPath];
    
    product = [productsListArray objectAtIndex:indexPath.row];

    cell.availableLabel.text = product.available;
    cell.brandLabel.text     = product.brand;
    cell.colorLabel.text     = product.color;
    cell.imageView.image     = [UIImage imageNamed:product.imageURL];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    product = [productsListArray objectAtIndex:indexPath.row];
    
    NSLog(@"%d",product.visible);
    if (product.visible == false)
    {
              return CGSizeMake(0.f, 0.f);
    }
        return CGSizeMake(140.f, 140.f);
}

- (IBAction)brandAction:(id)sender
{
    if ( filterViewController == nil)
    {
        filterViewController = [[FilterTableViewController alloc] init];
    }
    
    if (popOver == nil)
    {
        popOver = [[FPPopoverController alloc] initWithViewController:filterViewController];
    }
    
    NSLog(@"log selection pop %d",filterViewController.selectedFilter);

    
    button = sender;
    
    filterViewController.selectedFilter = button.tag;
    
    [popOver presentPopoverFromView:sender];
}

- (IBAction)AvailableAction:(id)sender
{
    AvailableTableViewController *availController = [[AvailableTableViewController alloc] init];
    FPPopoverController *popController = [[FPPopoverController alloc] initWithViewController:availController];
    [popController presentPopoverFromView:sender];
}

- (IBAction)colorAction:(id)sender
{
    ColorTableViewController *colorController = [[ColorTableViewController alloc] init];
    FPPopoverController *popOver = [[FPPopoverController alloc] initWithViewController:colorController];
    [popOver presentPopoverFromView:sender];
}

@end