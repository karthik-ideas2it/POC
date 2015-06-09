//
//  Feed.h
//  ConsumeWebService
//
//  Created by Karthikeyan on 6/5/15.
//  Copyright (c) 2015 Ideas2it. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feed : NSObject
{
    NSString *str1;
    
    NSMutableArray *FeedsArr;
    NSInteger SelectedFeed;
}

@property (nonatomic, retain)     NSString *str1;
@property (nonatomic, copy)     NSMutableArray *FeedsArr;
@property (nonatomic, assign)      NSInteger SelectedFeed;


+(id)SharedFeeds;
-(void)UpdateFeeds:(id)Feed;

@end
