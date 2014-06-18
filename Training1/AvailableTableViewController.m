//
//  AvailableTableViewController.m
//  Training1
//
//  Created by Vikash Soni on 12/06/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "AvailableTableViewController.h"

@interface AvailableTableViewController ()

@end

@implementation AvailableTableViewController
static   NSMutableArray *selectedRowsArray ;
@synthesize cellText;

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
    
    cellText = [[NSArray alloc] initWithObjects:@"1", @"0", nil];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"AvailCell"];
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
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AvailCell" forIndexPath:indexPath];
    
    // Configure the cell..
    
    cell.textLabel.text = [cellText objectAtIndex:indexPath.row];
    
    if ([selectedRowsArray containsObject:[cellText objectAtIndex:indexPath.row]])
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
    
    if ([selectedRowsArray containsObject:[cellText objectAtIndex:tappedIndexPath.row]])
    {
        [selectedRowsArray removeObject:[cellText objectAtIndex:tappedIndexPath.row]];
    }
    else
    {
        [selectedRowsArray addObject:[cellText objectAtIndex:tappedIndexPath.row]];
    }
    
    NSDictionary *sendDict = [NSDictionary dictionaryWithObject:selectedRowsArray forKey:@"avail"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"availFilterChanged" object:self userInfo:sendDict ];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:tappedIndexPath] withRowAnimation: UITableViewRowAnimationFade];
}

@end
