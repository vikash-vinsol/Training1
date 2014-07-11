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


-(instancetype)initWithName : (NSString *)filterName;
{
    self = [super init];
    
    values = [[NSMutableArray alloc] init];
    name   = filterName;
    
    return self;
}

-(void)addValue:(NSString *)value
{
    if (![values containsObject:value])
    {
        [values addObject:value];
    }
}

@end