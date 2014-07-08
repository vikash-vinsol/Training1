//
//  Filter.m
//  Training1
//
//  Created by Vikash Soni on 08/07/14.
//  Copyright (c) 2014 Vikash Soni. All rights reserved.
//

#import "Filter.h"

@implementation Filter

@synthesize values,name;


-(instancetype)init
{
    self = [super init];
    
    if (!values)
    {
        values = [[NSMutableArray alloc] init];

    }
    return self;
}

-(void)addValue:(NSString *)value
{
    if (![values containsObject:value])
    {
        [values addObject:value];
        NSLog(@"%@",values);
    }
}

@end