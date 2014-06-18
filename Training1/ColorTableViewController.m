//
//  ColorTableViewController.m
//  Training1
//
//  Created by Vikash Soni on 12/06/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "ColorTableViewController.h"
#import "AppDelegate.h"

@interface ColorTableViewController ()

@end

@implementation ColorTableViewController
{
    AppDelegate *appDelegate;
}

static   NSMutableArray *selectedRowsArray ;


+(void) initialize
{
    if (! selectedRowsArray)
        selectedRowsArray = [[NSMutableArray alloc] init];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ColorCell"];
    
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
    return [appDelegate.colorArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColorCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [appDelegate.colorArray objectAtIndex:indexPath.row];
    
    // Set the image of cell (Checked or not Checked)
    if ([selectedRowsArray containsObject:[appDelegate.colorArray objectAtIndex:indexPath.row]])
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
    
    if ([selectedRowsArray containsObject:[appDelegate.colorArray objectAtIndex:tappedIndexPath.row]])
    {
        [selectedRowsArray removeObject:[appDelegate.colorArray objectAtIndex:tappedIndexPath.row]];
    }
    else
    {
        [selectedRowsArray addObject:[appDelegate.colorArray objectAtIndex:tappedIndexPath.row]];
    }
    
    NSDictionary *sendDict = [NSDictionary dictionaryWithObject:selectedRowsArray forKey:@"color"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"colorFilterChanged" object:self userInfo:sendDict ];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:tappedIndexPath] withRowAnimation: UITableViewRowAnimationFade];
}

@end
