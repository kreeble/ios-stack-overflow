//
//  KRStackOverflowUserTableViewCell.m
//  ios-stack-overflow
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

#import "KRStackOverflowUserTableViewCell.h"

// macros to reduce code and improve readability for auto-layout
#import "ESAutoLayoutUtility.h"

#import "KRAppStyle.h"

NS_ASSUME_NONNULL_BEGIN

@implementation KRStackOverflowUserTableViewCell
// profile image view
static const CGFloat KRProfileImageViewSizePts	= 44.0;
static const CGFloat KRProfileImageViewLeftPts	= 4.0;

// name label
static const CGFloat KRNameLabelHeightPts	= 18.0;
static const CGFloat KRNameLabelLeftMargin	= 6.0;
static const CGFloat KRNameLabelRightMargin	= 4.0;
static const CGFloat KRNameLabelTopMargin	= 5.0;

// reputation label
static const CGFloat KRReputationLabelHeight		= 13.0;
static const CGFloat KRReputationLabelLeftMargin	= 0.0;
static const CGFloat KRReputationLabelTopMargin		= 3.5;

// badge count
// -- image view
static const CGFloat KRBadgeCountImageViewSizePts	= 10.0;
static const CGFloat KRBadgeCountImageViewLeftPts	= 6.0;

static const CGFloat KRFirstBadgeCountImageViewLeftMargin = 8.0;
// -- label
static const CGFloat KRBadgeCountLabelHeight		= 12.0;
static const CGFloat KRBadgeCountLabelLeft			= 4.0;
// ----

#pragma mark - Class Constants

+ (CGFloat)fixedHeight			{ return 48.0; }

#pragma mark - UITableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
}

#pragma mark - Profile Image

- (void)showProfileImageLoadingView:(BOOL)show {
	self.profileImageView.hidden = show;
	if (show) {
		[self.profileImageLoadingView startAnimating];
	} else {
		[self.profileImageLoadingView stopAnimating];
	}
}

#pragma mark - Auto-Layout

- (void)addAllConstraints {
	[self addConstraintsProfileImageView];
	[self addConstraintsProfileLoadingView];
	[self addConstraintsNameLabel];
	[self addConstraintsReputationLabel];
	[self addConstraintsBadgeCountViews];
}

#pragma mark ---- Profile Image View

- (void)addConstraintsProfileImageView {
	UIView *itView = self.profileImageView;
	// hug / resist
	HUG(itView, UILayoutPriorityDefaultHigh);
	RESIST(itView, UILayoutPriorityDefaultHigh);

	// size
	INSTALL_CONSTRAINTS(UILayoutPriorityRequired, @"profile image view width",
						[NSLayoutConstraint constraintWithItem:itView
													 attribute:NSLayoutAttributeWidth
													 relatedBy:NSLayoutRelationEqual
														toItem:nil
													 attribute:NSLayoutAttributeNotAnAttribute
													multiplier:1.0
													  constant:KRProfileImageViewSizePts]);
	INSTALL_CONSTRAINTS(UILayoutPriorityRequired, @"profile image view height",
						[NSLayoutConstraint constraintWithItem:itView
													 attribute:NSLayoutAttributeHeight
													 relatedBy:NSLayoutRelationEqual
														toItem:nil
													 attribute:NSLayoutAttributeNotAnAttribute
													multiplier:1.0
													  constant:KRProfileImageViewSizePts]);

	// vert
	CENTER_V(itView);

	// left
	INSTALL_CONSTRAINTS(UILayoutPriorityRequired, @"profile image view left",
						[NSLayoutConstraint constraintWithItem:itView
													 attribute:NSLayoutAttributeLeft
													 relatedBy:NSLayoutRelationEqual
														toItem:self.contentView
													 attribute:NSLayoutAttributeLeft
													multiplier:1.0
													  constant:KRProfileImageViewLeftPts]);
}

#pragma mark ---- Profile Loading View

- (void)addConstraintsProfileLoadingView {
	UIView *itView = self.profileImageLoadingView;
	// hug / resist
	HUG(itView, UILayoutPriorityDefaultHigh);
	RESIST(itView, UILayoutPriorityDefaultHigh);

	// size
	MATCH_SIZE(itView, self.profileImageView);

	// vert
	MATCH_CENTERS(itView, self.profileImageView);
}

#pragma mark ---- Name Label

- (void)addConstraintsNameLabel {
	UIView *itView = self.nameLabel;
	// hug / resist
	HUG(itView, UILayoutPriorityDefaultHigh);
	RESIST(itView, UILayoutPriorityDefaultHigh);

	// size
	INSTALL_CONSTRAINTS(UILayoutPriorityRequired, @"name label height",
						[NSLayoutConstraint constraintWithItem:itView
													 attribute:NSLayoutAttributeHeight
													 relatedBy:NSLayoutRelationEqual
														toItem:nil
													 attribute:NSLayoutAttributeNotAnAttribute
													multiplier:1.0
													  constant:KRNameLabelHeightPts]);

	// horiz
	INSTALL_CONSTRAINTS(UILayoutPriorityRequired, @"name label left",
						[NSLayoutConstraint constraintWithItem:itView
													 attribute:NSLayoutAttributeLeft
													 relatedBy:NSLayoutRelationEqual
														toItem:self.profileImageView
													 attribute:NSLayoutAttributeRight
													multiplier:1.0
													  constant:KRNameLabelLeftMargin]);
	INSTALL_CONSTRAINTS(UILayoutPriorityRequired, @"name label right",
						[NSLayoutConstraint constraintWithItem:itView
													 attribute:NSLayoutAttributeRight
													 relatedBy:NSLayoutRelationEqual
														toItem:self.contentView
													 attribute:NSLayoutAttributeRight
													multiplier:1.0
													  constant:-KRNameLabelRightMargin]);

	// vert
	INSTALL_CONSTRAINTS(UILayoutPriorityRequired, @"name label top",
						[NSLayoutConstraint constraintWithItem:itView
													 attribute:NSLayoutAttributeTop
													 relatedBy:NSLayoutRelationEqual
														toItem:self.contentView
													 attribute:NSLayoutAttributeTop
													multiplier:1.0
													  constant:KRNameLabelTopMargin]);
}

#pragma mark ---- Reputation Label

- (void)addConstraintsReputationLabel {
	UIView *itView = self.reputationLabel;
	// hug / resist
	HUG(itView, UILayoutPriorityDefaultHigh);
	RESIST(itView, UILayoutPriorityDefaultHigh);

	// size
	INSTALL_CONSTRAINTS(UILayoutPriorityRequired, @"reputation label height",
						[NSLayoutConstraint constraintWithItem:itView
													 attribute:NSLayoutAttributeHeight
													 relatedBy:NSLayoutRelationEqual
														toItem:nil
													 attribute:NSLayoutAttributeNotAnAttribute
													multiplier:1.0
													  constant:KRReputationLabelHeight]);

	// horiz
	INSTALL_CONSTRAINTS(UILayoutPriorityRequired, @"reputation label left",
						[NSLayoutConstraint constraintWithItem:itView
													 attribute:NSLayoutAttributeLeft
													 relatedBy:NSLayoutRelationEqual
														toItem:self.nameLabel
													 attribute:NSLayoutAttributeLeft
													multiplier:1.0
													  constant:KRReputationLabelLeftMargin]);

	// vert
	INSTALL_CONSTRAINTS(UILayoutPriorityRequired, @"reputation label top",
						[NSLayoutConstraint constraintWithItem:itView
													 attribute:NSLayoutAttributeTop
													 relatedBy:NSLayoutRelationEqual
														toItem:self.nameLabel
													 attribute:NSLayoutAttributeBottom
													multiplier:1.0
													  constant:KRReputationLabelTopMargin]);
}

#pragma mark ---- Badge Count

- (void)addConstraintsBadgeCountViews {
	[self addConstraintsBadgeCountImageView:self.goldBadgeImageView
								 viewToLeft:self.reputationLabel
					  viewToMatchCenterWith:self.reputationLabel];
	[self.goldBadgeImageView constraintNamed:KRBadgeCountImageViewLeftTag].constant = KRFirstBadgeCountImageViewLeftMargin;
	[self addConstraintsBadgeCountLabel:self.goldBadgeLabel
							 viewToLeft:self.goldBadgeImageView
				  viewToMatchCenterWith:self.goldBadgeImageView];

	[self addConstraintsBadgeCountImageView:self.silverBadgeImageView
								 viewToLeft:self.goldBadgeLabel
					  viewToMatchCenterWith:self.goldBadgeImageView];
	[self addConstraintsBadgeCountLabel:self.silverBadgeLabel
							 viewToLeft:self.silverBadgeImageView
				  viewToMatchCenterWith:self.goldBadgeLabel];

	[self addConstraintsBadgeCountImageView:self.bronzeBadgeImageView
								 viewToLeft:self.silverBadgeLabel
					  viewToMatchCenterWith:self.goldBadgeImageView];
	[self addConstraintsBadgeCountLabel:self.bronzeBadgeLabel
							 viewToLeft:self.bronzeBadgeImageView
				  viewToMatchCenterWith:self.goldBadgeLabel];
}

static NSString *const KRBadgeCountImageViewLeftTag = @"badge count image view left";

- (void)addConstraintsBadgeCountImageView:(UIImageView *)imageView
							   viewToLeft:(UIView *)viewToLeft
					viewToMatchCenterWith:(UIView *)viewToMatchCenterWith {
	UIView *itView = imageView;
	// hug / resist
	HUG(itView, UILayoutPriorityDefaultHigh);
	RESIST(itView, UILayoutPriorityDefaultHigh);

	// size
	INSTALL_CONSTRAINTS(UILayoutPriorityRequired, @"badge count image view width",
						[NSLayoutConstraint constraintWithItem:itView
													 attribute:NSLayoutAttributeWidth
													 relatedBy:NSLayoutRelationEqual
														toItem:nil
													 attribute:NSLayoutAttributeNotAnAttribute
													multiplier:1.0
													  constant:KRBadgeCountImageViewSizePts]);
	INSTALL_CONSTRAINTS(UILayoutPriorityRequired, @"badge count image view height",
						[NSLayoutConstraint constraintWithItem:itView
													 attribute:NSLayoutAttributeHeight
													 relatedBy:NSLayoutRelationEqual
														toItem:nil
													 attribute:NSLayoutAttributeNotAnAttribute
													multiplier:1.0
													  constant:KRBadgeCountImageViewSizePts]);

	// vert
	MATCH_CENTERV(viewToMatchCenterWith, itView);

	// horiz
	INSTALL_CONSTRAINTS(UILayoutPriorityRequired, KRBadgeCountImageViewLeftTag,
						[NSLayoutConstraint constraintWithItem:itView
													 attribute:NSLayoutAttributeLeft
													 relatedBy:NSLayoutRelationEqual
														toItem:viewToLeft
													 attribute:NSLayoutAttributeRight
													multiplier:1.0
													  constant:KRBadgeCountImageViewLeftPts]);
}

- (void)addConstraintsBadgeCountLabel:(UILabel *)label
						   viewToLeft:(UIView *)viewToLeft
				viewToMatchCenterWith:(UIView *)viewToMatchCenterWith {
	UIView *itView = label;
	// hug / resist
	HUG(itView, UILayoutPriorityDefaultHigh);
	RESIST(itView, UILayoutPriorityDefaultHigh);

	// size
	INSTALL_CONSTRAINTS(UILayoutPriorityRequired, @"badge count label height",
						[NSLayoutConstraint constraintWithItem:itView
													 attribute:NSLayoutAttributeHeight
													 relatedBy:NSLayoutRelationEqual
														toItem:nil
													 attribute:NSLayoutAttributeNotAnAttribute
													multiplier:1.0
													  constant:KRBadgeCountLabelHeight]);

	// horiz
	INSTALL_CONSTRAINTS(UILayoutPriorityRequired, @"badge count label left",
						[NSLayoutConstraint constraintWithItem:itView
													 attribute:NSLayoutAttributeLeft
													 relatedBy:NSLayoutRelationEqual
														toItem:viewToLeft
													 attribute:NSLayoutAttributeRight
													multiplier:1.0
													  constant:KRBadgeCountLabelLeft]);

	// vert
	MATCH_CENTERV(viewToMatchCenterWith, itView);
}

#pragma mark - Start / End

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self setUpStackOverflowTableViewCell];
	}
	return self;
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self setUpStackOverflowTableViewCell];
	}
	return self;
}

- (void)setUpStackOverflowTableViewCell {
	[self setUpViewComponents];
	[self addAllConstraints];
	[self configureStyle];
}

- (void)configureStyle {
	// font
	self.nameLabel.font				= [KRAppStyle stackOverflowUserNameFont];
	self.reputationLabel.font		= [KRAppStyle stackOverflowUserReputationFont];
	self.goldBadgeLabel.font		= [KRAppStyle stackOverflowUserBadgeCountFont];
	self.silverBadgeLabel.font		= [KRAppStyle stackOverflowUserBadgeCountFont];
	self.bronzeBadgeLabel.font		= [KRAppStyle stackOverflowUserBadgeCountFont];

	// text color
	self.nameLabel.textColor		= [KRAppStyle stackOverflowUserNameColor];
	self.reputationLabel.textColor	= [KRAppStyle stackOverflowUserReputationColor];
	self.goldBadgeLabel.textColor	= [KRAppStyle stackOverflowUserBadgeCountColor];
	self.silverBadgeLabel.textColor	= [KRAppStyle stackOverflowUserBadgeCountColor];
	self.bronzeBadgeLabel.textColor	= [KRAppStyle stackOverflowUserBadgeCountColor];

	// profile image
	//self.profileImageLoadingView.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1.0];
}

- (void)setUpViewComponents {
	// remove default views
	[self.textLabel removeFromSuperview];
	[self.detailTextLabel removeFromSuperview];
	[self.imageView removeFromSuperview];

	// profile image view
	UIImageView *imageView = [[UIImageView alloc] initWithImage:nil];
	_profileImageView = imageView;
	_profileImageView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.contentView addSubview:_profileImageView];

	// profile image loading view
	UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	_profileImageLoadingView = loadingView;
	_profileImageLoadingView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.contentView addSubview:_profileImageLoadingView];

	// name label
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
	_nameLabel = label;
	_nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self.contentView addSubview:_nameLabel];

	// reputation label
	label = [[UILabel alloc] initWithFrame:CGRectZero];
	_reputationLabel = label;
	_reputationLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self.contentView addSubview:_reputationLabel];

	// badges
	const NSUInteger kBadgesCount = 3;
	NSMutableArray<UIImageView *> *mutaImageViews = [NSMutableArray new];
	for (NSUInteger i = 0; i < kBadgesCount; i++) {
		imageView = [[UIImageView alloc] initWithImage:nil];
		imageView.layer.opaque = YES;
		imageView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
		imageView.layer.shouldRasterize = YES;
		imageView.translatesAutoresizingMaskIntoConstraints = NO;
		[mutaImageViews addObject:imageView];
	}
	_goldBadgeImageView = mutaImageViews[0];
	_goldBadgeImageView.image = [UIImage imageNamed:@"GoldBadge"];
	[self.contentView addSubview:_goldBadgeImageView];
	_silverBadgeImageView = mutaImageViews[1];
	_silverBadgeImageView.image = [UIImage imageNamed:@"SilverBadge"];
	[self.contentView addSubview:_silverBadgeImageView];
	_bronzeBadgeImageView = mutaImageViews[2];
	_bronzeBadgeImageView.image = [UIImage imageNamed:@"BronzeBadge"];
	[self.contentView addSubview:_bronzeBadgeImageView];
	mutaImageViews = nil;

	_goldBadgeLabel =  [[UILabel alloc] initWithFrame:CGRectZero];
	_goldBadgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self.contentView addSubview:_goldBadgeLabel];

	_silverBadgeLabel =  [[UILabel alloc] initWithFrame:CGRectZero];
	_silverBadgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self.contentView addSubview:_silverBadgeLabel];

	_bronzeBadgeLabel =  [[UILabel alloc] initWithFrame:CGRectZero];
	_bronzeBadgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self.contentView addSubview:_bronzeBadgeLabel];
}

@end

NS_ASSUME_NONNULL_END
