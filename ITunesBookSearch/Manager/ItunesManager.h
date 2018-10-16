//
//  ItunesManager.h
//  ITunesBookSearch
//
//  Created by MetaTedi on 10/16/18.
//  Copyright © 2018 Tedev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItunesManager : NSObject

+ (NSURLSessionDataTask*)searchBooks:(NSString*)term completionHandler: (void (^)(NSArray*,NSError * _Nullable error))completionHandler;

@end
