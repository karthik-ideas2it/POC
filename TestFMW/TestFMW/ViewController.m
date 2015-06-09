//
//  ViewController.m
//  TestFMW
//
//  Created by Karthikeyan on 6/4/15.
//  Copyright (c) 2015 Ideas2it. All rights reserved.
//

#import "ViewController.h"
#import <FMW/TableViewController.h>
#import <FMW/Feed.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Call the Controller from Library
    
    
    TableViewController *tvc=[[TableViewController alloc]init];
    tvc.view.frame=self.view.frame;
    UINavigationController *nvc=[[UINavigationController alloc] initWithRootViewController:tvc];
   
    [self addChildViewController:nvc];
    [self.view addSubview:nvc.view];
    
    // To Mock the Push for Add Operation
    
//    UIButton *TEMP =[[UIButton alloc] init];
//    [TEMP setFrame:CGRectMake(nvc.view.frame.size.width-60, 15, 50, 30)];
//    [TEMP setTitle:@"ADD" forState:UIControlStateNormal];
//    [TEMP setBackgroundColor:[UIColor grayColor]];
//    [TEMP bringSubviewToFront:self.view];
//    [TEMP addTarget:self action:@selector(AddOneRow) forControlEvents:UIControlEventTouchUpInside];
//    [nvc.view addSubview:TEMP];
    
}
-(void)AddOneRow{
    Feed *feeds=[Feed SharedFeeds];
    NSMutableDictionary *dict1=[[feeds.FeedsArr objectAtIndex:1] mutableCopy];
    NSMutableDictionary *dict2=[[dict1 valueForKey:@"im:name"] mutableCopy];
    [dict2 setValue:@"test Push " forKey:@"label"];
    [dict1 setObject:dict2 forKey:@"im:name"];
    
    
    [feeds UpdateFeeds:dict1];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
