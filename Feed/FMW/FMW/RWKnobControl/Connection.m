//
//  Connection.m
//  ConsumeWebService
//
//  Created by MAC on 6/2/15.
//  Copyright (c) 2015 Ideas2it. All rights reserved.
//

#import "Connection.h"
NSMutableData *ReceivedData;
NSURLConnection *Conn;

@implementation Connection
@synthesize delegate,StrIdendity;
- (id)init
{
    if (![super init]) return nil;
    
    
    return self;
}

-(void)RequestWithURL:(NSURL *)requestURL withParams:(NSMutableDictionary *)Params requestmethod:(NSString *)Type withIdendity:(NSString *)Idendity
{
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topfreeapplications/limit=25/json"]];
    
    StrIdendity=Idendity;
    if([Params count]>0)
    {
        NSString *str= @"";
        
        for (NSString * keys in Params)
        {
            str=[NSString stringWithFormat:@"%@%@=\"%@\"&",str,keys,[Params valueForKey:keys]];
        }
        
        str = [str substringWithRange:NSMakeRange(0, str.length-1)];
        [request setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [request setHTTPMethod:Type];
    Conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [Conn start];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    ReceivedData = nil;
    ReceivedData=[NSMutableData data];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [ReceivedData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Error in Connection : %@",error);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    id response=[NSJSONSerialization JSONObjectWithData:ReceivedData options:NSJSONReadingAllowFragments error:nil];

    [self.delegate FinishedLoadingConnectionWithObject:response Idendity:StrIdendity];
    
}
-(void)CancelConnection{
    [Conn cancel];
    
}
@end
