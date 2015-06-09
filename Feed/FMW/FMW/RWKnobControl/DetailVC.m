//
//  DetailVC.m
//  FMW
//
//  Created by Karthikeyan on 6/4/15.
//  Copyright (c) 2015 Ideas2it. All rights reserved.
//

#import "DetailVC.h"
#import "Feed.h"
@interface DetailVC ()

@end

NSMutableDictionary *dict_Feed;

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    Feed *feedList=[Feed SharedFeeds];
    dict_Feed = [feedList.FeedsArr objectAtIndex:feedList.SelectedFeed];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Title";
        case 1:
            return @"Rights";
            
        case 2:
            return @"Description";
            
        default:
            break;
    }
    return @"";
}
-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section ==2)    return 1;
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2)
    {
        UILabel *lbl=[[UILabel alloc]init];
        [lbl setText:[NSString stringWithFormat:@"%@",[[dict_Feed valueForKey:@"summary"] valueForKey:@"label"]]];
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18]};
        // NSString class method: boundingRectWithSize:options:attributes:context is
        // available only on ios7.0 sdk.
        CGRect rect = [lbl.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, CGFLOAT_MAX)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attributes
                                             context:nil];
        
        return rect.size.height+10;
        
    }
    return tableView.rowHeight;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] init];
        
    }
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text=[NSString stringWithFormat:@"%@",[[dict_Feed valueForKey:@"title"] valueForKey:@"label"]];
            
            break;
            
        case 1:
            cell.textLabel.text=[NSString stringWithFormat:@"%@",[[dict_Feed valueForKey:@"rights"] valueForKey:@"label"]];
            break;
            
        case 2:
            cell.textLabel.text=[NSString stringWithFormat:@"%@",[[dict_Feed valueForKey:@"summary"] valueForKey:@"label"]];
            UILabel *lbl=[[UILabel alloc]init];
            [lbl setText:[NSString stringWithFormat:@"%@",[[dict_Feed valueForKey:@"summary"] valueForKey:@"label"]]];
            
            NSDictionary *attributes = @{NSFontAttributeName: [lbl  font]};
            // NSString class method: boundingRectWithSize:options:attributes:context is
            // available only on ios7.0 sdk.
            CGRect rect = [lbl.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, CGFLOAT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attributes
                                                 context:nil];
            [lbl setFrame:CGRectMake(5, 5, self.view.frame.size.width-15, rect.size.height)];
            [lbl setNumberOfLines:(rect.size.height/20)+2];
            //            [lbl setLineBreakMode:NSLineBreakByWordWrapping];
            [lbl setTextAlignment:NSTextAlignmentJustified];
            
            //[cell addSubview:lbl];
            UITextView *tst=[[UITextView alloc]init];
            [tst setText:lbl.text];
            [tst setFont:[UIFont systemFontOfSize:17]];
            [tst setScrollEnabled:NO];
            
            [tst setFrame:CGRectMake(5, 5, self.view.frame.size.width-15, rect.size.height+20)];
            [cell addSubview:tst];
            
            
            break;
            
            
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
