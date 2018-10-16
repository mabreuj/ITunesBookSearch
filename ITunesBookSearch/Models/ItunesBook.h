//
//  ItunesBook.h
//  ITunesBookSearch
//
//  Created by MetaTedi on 10/16/18.
//  Copyright © 2018 Tedev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItunesBook : NSObject

@property NSString* artworkUrl;
@property NSString* title;
@property NSString* bookDescription;
@property NSString* artistName;
@property NSString* formattedPrice;
@property NSDate* releaseDate;
@property NSInteger fileSizeBytes;

@end
