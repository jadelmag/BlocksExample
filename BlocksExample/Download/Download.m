//
//  Download.m
//  BlocksExample
//
//  Created by Javier Delgado on 09/08/13.
//  Copyright (c) 2013 Javier Delgado. All rights reserved.
//

#import "Download.h"

@implementation Download

+(id)downloadWithURL:(NSString *)requestUrl completionBlock:(completionBlock_t)blockCompleted errorBlock:(errorBlock_t)blockError {
    if ([requestUrl hasPrefix:@"http"] == NO) {
        NSLog(@"URL not valid!!");
    }
    return [[self alloc] initWithRequest:requestUrl completionBlock:blockCompleted errorBlock:blockError];
}

- (id)initWithRequest:(NSString *)requestUrl completionBlock:(completionBlock_t)blockCompleted errorBlock:(errorBlock_t)blockError {
    
    if (self = [super init]) {
        dataReceived = [[NSMutableData alloc] init];
        completionBlock = [blockCompleted copy];
        errorBlock = [blockError copy];
        
        NSURL *url = [NSURL URLWithString:requestUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [dataReceived setLength:0];
    size = [response expectedContentLength];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [dataReceived appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (completionBlock != nil) {
        completionBlock(dataReceived);
    }
    completionBlock = nil;
    errorBlock = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Failure to download the file: %@",error);
    if (error != nil) {
        errorBlock(error);
    }
    completionBlock = nil;
    errorBlock = nil;
}

@end
