//
//  KRStackOverflowUserTableViewCell.h
//  wag-ios-challenge
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KRStackOverflowUserTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *reputationLabel;

// we could componentize the badge counts into a view but this will reduce performance
// because of rendering another layer of alpha transparency.
@property (nonatomic, strong) UIImageView *goldBadgeImageView;
@property (nonatomic, strong) UILabel *goldBadgeLabel;
@property (nonatomic, strong) UIImageView *silverBadgeImageView;
@property (nonatomic, strong) UILabel *silverBadgeLabel;
@property (nonatomic, strong) UIImageView *bronzeBadgeImageView;
@property (nonatomic, strong) UILabel *bronzeBadgeLabel;

#pragma mark - Class Constants
+ (CGFloat)fixedHeight;
@end

NS_ASSUME_NONNULL_END
