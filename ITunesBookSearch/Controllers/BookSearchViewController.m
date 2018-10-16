//
//  BookSearchViewController.m
//  ITunesBookSearch
//
//  Created by MetaTedi on 10/15/18.
//  Copyright © 2018 Tedev. All rights reserved.
//
#import <SDWebImage/UIImageView+WebCache.h>
#import "BookSearchViewController.h"
#import "ItunesBook.h"
#import "BookViewController.h"
#import "BookTableViewCell.h"
#import "ItunesManager.h"

@interface BookSearchViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *noBooksPlaceholderView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property NSArray* books;
@property NSString* searchedText;
@property NSURLSessionDataTask* searchTask;

@end

@implementation BookSearchViewController

CGFloat const bookCellHeight = 100.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.books = [NSArray new];
    self.searchedText = @"";
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI

- (void)updateUI {
    [self.tableView reloadData];
    [self.noBooksPlaceholderView setHidden:!([self.books count] == 0 && ![self.searchedText isEqualToString:@""])];
}

- (void)startLoading {
    [self.activityIndicator startAnimating];
}

- (void)stopLoading {
    [self.activityIndicator stopAnimating];
}

#pragma mark - TableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.books count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BookCell" forIndexPath:indexPath];
    ItunesBook* book = [self.books objectAtIndex:indexPath.row];
    cell.titleLabel.text = book.title;
    cell.descriptionLabel.text = book.bookDescription;
    [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString: book.artworkUrl] placeholderImage:[UIImage imageNamed:@"bookPlaceHolder"]];
    return cell;
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"ShowBook" sender:[self.books objectAtIndex:indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return bookCellHeight;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.books count] == 0 ? @"Start searching for books!" : @"Books";
}
#pragma mark - SearchBar

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.searchedText = searchText;
    [self startLoading];
    if (self.searchTask != nil) {
        [self.searchTask cancel];
    }
    self.searchTask = [ItunesManager searchBooks:self.searchedText completionHandler:^(NSArray* books, NSError* _Nullable error) {
        self.books = books;
        self.searchTask = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateUI];
            [self stopLoading];
        });
    }];
    [self.searchTask resume];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString: @"ShowBook"]){
        ((BookViewController*)segue.destinationViewController).book = (ItunesBook*)sender;
    }
}


@end
