//
//  Feed.m
//  ConsumeWebService
//
//  Created by Karthikeyan on 6/5/15.
//  Copyright (c) 2015 Ideas2it. All rights reserved.
//

#import "Feed.h"

@implementation Feed
@synthesize str1;
@synthesize FeedsArr;
@synthesize SelectedFeed;
+(id)SharedFeeds{
    
    static Feed *shareFeed=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareFeed = [[self alloc] init];
    });
 
    return shareFeed;
 
}

- (id)init {

    if (self = [super init]) {
        str1=[[NSString alloc] init];
        FeedsArr=[NSMutableArray array];
        SelectedFeed=0;
    }
    
    return self;
}
-(void)UpdateFeeds:(id)Feed{
//    FeedsArr is responsing as immutable object
    NSMutableArray *arr1=[[NSMutableArray alloc] init];
    arr1=[FeedsArr mutableCopy];
    [arr1 addObject:Feed];
    
    FeedsArr=[arr1 mutableCopy];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateFeedsList"
                                                        object:nil];
}

@end
