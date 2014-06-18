//
//  BrandTableViewController.m
//  Training1
//
//  Created by Vikash Soni on 12/06/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "BrandTableViewController.h"
#import "AppDelegate.h"

@interface BrandTableViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation BrandTableViewController

static   NSMutableArray *selectedRowsArray ;

+(void) initialize
{
    if (! selectedRowsArray)
        selectedRowsArray = [[NSMutableArray alloc] init];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"BrandCell"];
    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [appDelegate.brandArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BrandCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [appDelegate.brandArray objectAtIndex:indexPath.row];
    
    // Set the image of cell (Checked or not Checked)
    if ([selectedRowsArray containsObject:[appDelegate.brandArray objectAtIndex:indexPath.row]])
    {
        cell.imageView.image = [UIImage imageNamed:@"checked.png"];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"unchecked.png"];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleChecking:)];
    [cell.imageView addGestureRecognizer:tap];
    cell.imageView.userInteractionEnabled = YES;
    
    return cell;
}

- (void) handleChecking:(UITapGestureRecognizer *)tapRecognizer
{
    CGPoint tapLocation = [tapRecognizer locationInView:self.tableView];
    NSIndexPath *tappedIndexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
    
    if ([selectedRowsArray containsObject:[appDelegate.brandArray objectAtIndex:tappedIndexPath.row]])
    {
        [selectedRowsArray removeObject:[appDelegate.brandArray objectAtIndex:tappedIndexPath.row]];
    }
    else
    {
        [selectedRowsArray addObject:[appDelegate.brandArray objectAtIndex:tappedIndexPath.row]];
    }
    
    NSDictionary *sendDict = [NSDictionary dictionaryWithObject:selectedRowsArray forKey:@"brand"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"brandFilterChanged" object:self userInfo:sendDict ];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:tappedIndexPath] withRowAnimation: UITableViewRowAnimationFade];
}

@end
