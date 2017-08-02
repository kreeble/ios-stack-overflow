//
//  KRStackOverflowUserViewController.m
//  wag-ios-challenge
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

#import "KRStackOverflowUserViewController.h"

// view
#import "KRStackOverflowUserTableViewCell.h"

// auto-layout
#import "ESAutoLayoutUtility.h"

// domain model
#import "KRStackOverflowUser.h"
#import "KRStackOverflowUserBadgeCounts.h"

// api manager
#import "KRStackOverflowApiManager.h"

// remote image cache
#import "KRRemoteImageCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface KRStackOverflowUserViewController ()
// users
@property (nonatomic, copy, readwrite) NSArray<KRStackOverflowUser *> *users;

// api manager
@property (nonatomic, strong) KRStackOverflowApiManager *apiManager;

// loading view
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@end

@implementation KRStackOverflowUserViewController

// table cell
#define KRUserTableCellId	@"KRStackOverflowUserTableViewCell"
// ----

#pragma mark - Loading View

- (void)showLoadingView:(BOOL)show {
	if (show) {
		[self.loadingView startAnimating];
	} else {
		[self.loadingView stopAnimating];
	}
	self.loadingView.hidden = !show;
}

#pragma mark - API Manager

- (void)fetchUsers {
	__weak typeof(self) weakSelf = self;
	[self.apiManager fetchUsersWithCompletion:^(NSArray<id> *users, NSError * _Nullable error)
	 {
		 typeof(self) strongSelf = weakSelf;
		 strongSelf.users = users;
		 [strongSelf.tableView reloadData];
		 [strongSelf showLoadingView:NO];
	 }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KRUserTableCellId forIndexPath:indexPath];
	[self configureCell:cell atIndexPath:indexPath];
	return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	KRStackOverflowUserTableViewCell *userCell = (KRStackOverflowUserTableViewCell *)cell;
	KRStackOverflowUser *user = self.users[indexPath.row];

	// profile image
	UIImage *profileImage = [KRRemoteImageCache fastCachedImageForUrl:user.profileImage];
	if (profileImage != nil) {
		NSLog(@"in memory cache hit!");
		userCell.profileImageView.image = profileImage;
		[userCell showProfileImageLoadingView:NO];
	} else {
		[userCell showProfileImageLoadingView:YES];
		__weak typeof(self) weakSelf = self;
		[KRRemoteImageCache slowCachedImageForUrl:user.profileImage
									   completion:^(UIImage *_Nullable image)
		 {
			 typeof(self) strongSelf = weakSelf;
			 KRStackOverflowUserTableViewCell *visibleUserCell = [strongSelf.tableView cellForRowAtIndexPath:indexPath];
			 if (visibleUserCell != nil) {
				 [visibleUserCell showProfileImageLoadingView:NO];
				 visibleUserCell.profileImageView.image = (image != nil ? image : [UIImage imageNamed:@"UserEmptyProfileImage"]);
			 }
		 }];
	}

	userCell.nameLabel.text = user.displayName;
	userCell.reputationLabel.text = [NSString localizedStringWithFormat:@"%@", @(user.reputation)];
	userCell.goldBadgeLabel.text = [@(user.badgeCounts.gold) stringValue];
	userCell.silverBadgeLabel.text = [@(user.badgeCounts.silver) stringValue];
	userCell.bronzeBadgeLabel.text = [@(user.badgeCounts.bronze) stringValue];
}

#pragma mark - UITableViewDelegate
/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - View

- (void)viewDidLoad {
	[super viewDidLoad];

	// setup view
	[self setUpTableView];
	[self setUpLoadingView];

	// initial actions
	[self showLoadingView:YES];
	[self fetchUsers];
}

- (void)setUpTableView {
	// cell
	[self.tableView registerClass:[KRStackOverflowUserTableViewCell class]
		   forCellReuseIdentifier:KRUserTableCellId];
	self.tableView.rowHeight = [KRStackOverflowUserTableViewCell fixedHeight];

	// remove separators for no content
	UIView *footerView = [[UIView alloc] initWithFrame:(CGRect) {0, 0, 0, 0}];
	self.tableView.tableFooterView = footerView;
}

- (void)setUpLoadingView {
	UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	self.loadingView = loadingView;
	self.tableView.backgroundView = self.loadingView;

	// don't use autolayout since it will flicker on scroll
	self.loadingView.frame = (CGRect) { 0, 0, 36, 36 };
	self.loadingView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
}

#pragma mark - Start / End

- (instancetype)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]) {
		[self setUpStackOverflowUserViewController];
	}
	return self;
}

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
						 bundle:(nullable NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		[self setUpStackOverflowUserViewController];
	}
	return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self setUpStackOverflowUserViewController];
	}
	return self;
}

- (void)setUpStackOverflowUserViewController {
	// users
	_users = @[];

	// api manager
	_apiManager = [KRStackOverflowApiManager new];

	// view controller
	self.title = @"Stack Overflow Users";
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];

	NSLog(@"Received memory warning.");
	[KRRemoteImageCache clearInMemoryCache];
}

@end

NS_ASSUME_NONNULL_END
