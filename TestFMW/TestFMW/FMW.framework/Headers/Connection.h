//
//  Connection.h
//  ConsumeWebService
//
//  Created by MAC on 6/2/15.
//  Copyright (c) 2015 Ideas2it. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ConectionDelegate;

@interface Connection : NSURLConnection <NSURLConnectionDelegate>
{
    id <ConectionDelegate> delegate;
    NSString *Indendity;
    
}
@property (nonatomic, retain)     id <ConectionDelegate> delegate;
@property (nonatomic, assign)      NSString *StrIdendity;

-(void)RequestWithURL:(NSURL *)requestURL withParams:(NSMutableDictionary *)Params requestmethod:(NSString *)Type withIdendity:(NSString *)StrIdendity;


@end

@protocol ConectionDelegate

-(void)FinishedLoadingConnectionWithObject:(id)ReceivedObject Idendity:(NSString *)Idendity;

@end