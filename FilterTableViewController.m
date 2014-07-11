//
//  FilterTableViewController.m
//  Training1
//
//  Created by Vikash Soni on 18/06/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "FilterTableViewController.h"
#import "AppDelegate.h"
#import "filter.h"

@interface FilterTableViewController ()
{
    AppDelegate *appDelegate;
    NSMutableArray *filterArray;
}

@end

@implementation FilterTableViewController

static   NSMutableArray *selectedRowsColorArray ;
static   NSMutableArray *selectedRowsBrandArray ;
static   NSMutableArray *selectedRowsAvailArray ;
static   NSMutableArray *selectedRowsArray ;

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

+(void) initialize
{
    if (! selectedRowsArray)
        selectedRowsArray = [[NSMutableArray alloc] init];
    
    if (! selectedRowsColorArray)
        selectedRowsColorArray = [[NSMutableArray alloc] init];
    
    if (! selectedRowsBrandArray)
        selectedRowsBrandArray = [[NSMutableArray alloc] init];
    
    if (! selectedRowsAvailArray)
        selectedRowsAvailArray = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    filterArray = [[NSMutableArray alloc] init];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Filter_Cell"];
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
}

-(void)viewWillAppear:(BOOL)animated
{   
    switch (_selectedFilter)
    {
        case 1:
            filterArray = appDelegate.brandFilter.values;
            selectedRowsArray = selectedRowsBrandArray;
            break;
            
        case 2:
            filterArray = appDelegate.colorFilter.values;
            selectedRowsArray = selectedRowsColorArray;
            break;
            
        case 3:
            filterArray = [NSMutableArray arrayWithObjects:@"1",@"0", nil];
            selectedRowsArray = selectedRowsAvailArray;
            break;

        default:
            break;
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return filterArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Filter_Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [filterArray objectAtIndex:indexPath.row];
    
    if ([selectedRowsArray containsObject:[filterArray objectAtIndex:indexPath.row]])
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
    
    if ([selectedRowsArray containsObject:[filterArray objectAtIndex:tappedIndexPath.row]])
    {
        [selectedRowsArray removeObject:[filterArray objectAtIndex:tappedIndexPath.row]];
    }
    else
    {
        [selectedRowsArray addObject:[filterArray objectAtIndex:tappedIndexPath.row]];
        NSLog(@"log final  %@",selectedRowsArray);
    }
    
    NSDictionary *sendDict = [NSDictionary dictionaryWithObject:selectedRowsArray forKey:@"Filters"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FilterChanged" object:self userInfo:sendDict ];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:tappedIndexPath] withRowAnimation: UITableViewRowAnimationFade];
}

@end
