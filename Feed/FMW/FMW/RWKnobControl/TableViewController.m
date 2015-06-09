//
//  TableViewController.m
//  FMW
//
//  Created by Karthikeyan on 6/4/15.
//  Copyright (c) 2015 Ideas2it. All rights reserved.
//

#import "TableViewController.h"
#import "DetailVC.h"
#import "Feed.h"
@interface TableViewController ()

@end
NSMutableArray *Arr_feeds;
Feed *feedList;
@implementation TableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
//Fetch info from Webservice
    
    
    
    if(feedList ==nil)
    {
        feedList=[[Feed alloc] init];
        
    }
    feedList = [Feed SharedFeeds];
    [self FetchFeedList];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(UpdateFeedlisting)
                                                 name:@"UpdateFeedsList"
                                               object:nil];

}

-(void)FetchFeedList
{
    
    NSURL *url=[NSURL URLWithString:@"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topfreeapplications/limit=25/json"];
    Connection *conn=[[Connection alloc] init];
    [conn RequestWithURL:url withParams:nil requestmethod:@"POST" withIdendity:@"SAME"];
    conn.delegate =self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)FinishedLoadingConnectionWithObject:(id)ReceivedObject Idendity:(NSString *)Idendity{

    NSMutableDictionary *Dict=(NSMutableDictionary *)ReceivedObject;
    feedList.FeedsArr=[[Dict  valueForKey:@"feed"] valueForKey:@"entry"];
    [self UpdateFeedlisting];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [feedList.FeedsArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" ];
    if(cell==nil)
    {
        cell= [[UITableViewCell alloc]init];
    }
    cell.textLabel.text=[[[feedList.FeedsArr objectAtIndex:indexPath.row] valueForKey:@"im:name" ] valueForKey:@"label"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailVC *dvc=[[DetailVC alloc] init];
    feedList.SelectedFeed=indexPath.row;
    [feedList UpdateFeeds:[[feedList.FeedsArr objectAtIndex:indexPath.row] mutableCopy]];
    
    [self.navigationController pushViewController:dvc animated:YES];
    
//    [self presentViewController:dvc animated:YES completion:nil];
    
}

-(void)UpdateFeedlisting{
    [self.tableView reloadData];
    
}
@end
