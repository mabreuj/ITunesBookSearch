//
//  ItunesBook.m
//  ITunesBookSearch
//
//  Created by MetaTedi on 10/16/18.
//  Copyright © 2018 Tedev. All rights reserved.
//

#import "ItunesBook.h"

@implementation ItunesBook

-(id)initWithDict:(NSDictionary*)dict{
    static NSDateFormatter* dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    }
    self.artistName = [dict valueForKey:@"artistName"];
    self.artworkUrl = [dict valueForKey:@"artworkUrl100"];
    // The description is an HTML but for the sake of simplisity I'm just presenting it as is.
    self.bookDescription = [dict valueForKey:@"description"];
    self.fileSizeBytes = [[dict valueForKey:@"fileSizeBytes"] integerValue];
    self.formattedPrice = [dict valueForKey:@"formattedPrice"];
    self.releaseDate = [dateFormatter dateFromString:[dict valueForKey:@"releaseDate"]];
    self.title = [dict valueForKey:@"trackName"];
    
    return self;
}

@end
