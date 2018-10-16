//
//  ItunesManager.m
//  ITunesBookSearch
//
//  Created by MetaTedi on 10/16/18.
//  Copyright © 2018 Tedev. All rights reserved.
//

#import "ItunesManager.h"
#import "ItunesBook.h"

@implementation ItunesManager

static NSString* itunesApi = @"https://itunes.apple.com";

+ (NSURLSessionDataTask*)makeRequestWithUri:(NSString*)uri completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler  {
    // making a GET request to /init
    NSString *targetUrl = [NSString stringWithFormat:@"%@/%@", itunesApi, uri];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    NSURLSessionDataTask* session = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:completionHandler];
    return session;
}

+ (NSURLSessionDataTask*)searchBooks:(NSString*)term completionHandler: (void (^)(NSArray*,NSError * _Nullable error))completionHandler {
    return [self makeRequestWithUri:[NSString stringWithFormat:@"search?term=%@&entity=ebook",term] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil,error);
        } else {
            NSError *parseError = nil;
            NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:0
                                                                   error:&parseError];
            if (!parseError) {
                NSMutableArray* books = [NSMutableArray new];
                for (NSDictionary* bookDict in [jsonArray objectForKey:@"results"]) {
                    [books addObject: [[ItunesBook alloc] initWithDict:bookDict]];
                }
                completionHandler([NSArray arrayWithArray:books],nil);

            } else {
                NSString *err = [parseError localizedDescription];
                NSLog(@"Encountered error parsing: %@", err);
                completionHandler(nil,parseError);
            }

        }
        
    }];
}

@end
