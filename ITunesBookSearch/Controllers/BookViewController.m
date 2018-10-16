//
//  BookViewController.m
//  ITunesBookSearch
//
//  Created by MetaTedi on 10/16/18.
//  Copyright © 2018 Tedev. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "BookViewController.h"

@interface BookViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property NSDateFormatter* dateFormatter;

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dateFormatter = [NSDateFormatter new];
    [self.dateFormatter setDateFormat:@"MMM dd yyyy"];
    [self loadUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Update

- (void)loadUI {
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.book.artworkUrl] placeholderImage:[UIImage imageNamed:@"bookPlaceHolder"]];
    [self setTitle:self.book.title];
    self.titleLabel.text = self.book.title;
    self.artistNameLabel.text = self.book.artistName;
    self.releaseDateLabel.text = [self.dateFormatter stringFromDate:self.book.releaseDate];
    self.bookDescriptionLabel.text = self.book.bookDescription;
    self.priceLabel.text = self.book.formattedPrice;
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
