//
//  Download.h
//  BlocksExample
//
//  Created by Javier Delgado on 09/08/13.
//  Copyright (c) 2013 Javier Delgado. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completionBlock_t)(NSData *datos);
typedef void(^errorBlock_t)(NSError *error);

@interface Download : NSObject  <NSURLConnectionDataDelegate> {
    NSMutableData *dataReceived;
    completionBlock_t completionBlock;
    errorBlock_t errorBlock;
    CGFloat size;
}

+(id)downloadWithURL:(NSString *)requestUrl completionBlock:(completionBlock_t)blockCompleted errorBlock:(errorBlock_t)blockError;

@end
