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

@interface BookSearchViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *noBooksPlaceholderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activityIndicator;

@property NSArray* books;
@property NSString* searchedText;

@end

@implementation BookSearchViewController

CGFloat const bookCellHeight = 100.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.books = [NSArray new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    ItunesBook* book = [ItunesBook new];
    book.artistName = @"Jhon Cena";
    book.artworkUrl = @"https://is5-ssl.mzstatic.com/image/thumb/Publication18/v4/7f/62/c4/7f62c4ab-6157-1aac-e353-2df35ab85453/source/100x100bb.jpg";
    book.bookDescription = @"Tempting boys to be what they should be—giving them in wholesome form what they want—that is the purpose and power of Scouting. To help parents and leaders of youth secure books boys like best that are also best for boys, the Boy Scouts of America organized EVER";
    self.books = [self.books arrayByAddingObject:book];
    [self.tableView reloadData];
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
