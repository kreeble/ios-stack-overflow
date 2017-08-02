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

// domain model
#import "KRStackOverflowUser.h"
#import "KRStackOverflowUserBadgeCounts.h"

// api manager
#import "KRStackOverflowApiManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface KRStackOverflowUserViewController ()
// users
@property (nonatomic, copy, readwrite) NSArray<KRStackOverflowUser *> *users;

// api manager
@property (nonatomic, strong) KRStackOverflowApiManager *apiManager;
@end

@implementation KRStackOverflowUserViewController
#define KRUserTableCellId	@"KRStackOverflowUserTableViewCell"
// ----

#pragma mark - API Manager

- (void)fetchUsers {
	__weak typeof(self) weakSelf = self;
	[self.apiManager fetchUsersWithCompletion:^(NSArray<id> *users, NSError * _Nullable error)
	 {
		 typeof(self) strongSelf = weakSelf;
		 strongSelf.users = users;
		 [strongSelf.tableView reloadData];
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

	userCell.profileImageView.image = [UIImage imageNamed:@"TEST-128"];
	userCell.nameLabel.text = user.displayName;
	userCell.reputationLabel.text = [NSString localizedStringWithFormat:@"%@", @(user.reputation)];
	userCell.goldBadgeLabel.text = [@(user.badgeCounts.bronze) stringValue];
	userCell.silverBadgeLabel.text = [@(user.badgeCounts.bronze) stringValue];
	userCell.bronzeBadgeLabel.text = [@(user.badgeCounts.bronze) stringValue];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - View

- (void)viewDidLoad {
	[super viewDidLoad];

	[self setUpTableView];

	//[self fetchUsers];
	[self DEBUGSetUpTestUsers];
}

- (void)DEBUGSetUpTestUsers {
	KRStackOverflowUser *a = [KRStackOverflowUser new];
	a.userId		= 1000;
	a.reputation	= 963816;
	a.displayName	= @"Jon Skeet";
	a.profileImage	= [NSURL URLWithString:@"https://www.gravatar.com/avatar/6d8ebb117e8d83d74ea95fbdd0f87e13?s=128&d=identicon&r=PG"];
	a.badgeCounts	= [KRStackOverflowUserBadgeCounts new];
	a.badgeCounts.bronze = 7868;
	a.badgeCounts.silver = 8689;
	a.badgeCounts.gold = 1592;

	KRStackOverflowUser *b = [KRStackOverflowUser new];
	b.userId		= 1000;
	b.reputation	= 746755;
	b.displayName	= @"Rihanna Superlongmiddlename RiRi Lastname";
	b.profileImage	= [NSURL URLWithString:@"https://www.gravatar.com/avatar/e3a181e9cdd4757a8b416d93878770c5?s=128&d=identicon&r=PG"];
	b.badgeCounts	= [KRStackOverflowUserBadgeCounts new];
	b.badgeCounts.bronze = 123;
	b.badgeCounts.silver = 35989;
	b.badgeCounts.gold = 12398;
	self.users = @[a, b];
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
}

@end

NS_ASSUME_NONNULL_END
