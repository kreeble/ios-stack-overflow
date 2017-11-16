//
//  KRAppStyle.m
//  ios-stack-overflow
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

#import "KRAppStyle.h"

NS_ASSUME_NONNULL_BEGIN

@implementation KRAppStyle

#pragma mark - Generic

+ (UIFont *)baseFont {
	return [UIFont systemFontOfSize:1];
}

+ (UIFont *)baseLightFont {
	return [UIFont systemFontOfSize:1 weight:UIFontWeightLight];
}

+ (UIFont *)baseBoldFont {
	return [UIFont boldSystemFontOfSize:1];
}

#pragma mark - Stack Overflow User Cell

+ (UIFont *)stackOverflowUserNameFont {
	return [[self baseLightFont] fontWithSize:14.5];
}

+ (UIColor *)stackOverflowUserNameColor {
	return [UIColor colorWithWhite:0.05 alpha:1.0];
}

+ (UIFont *)stackOverflowUserReputationFont {
	return [[self baseBoldFont] fontWithSize:12.5];
}

+ (UIColor *)stackOverflowUserReputationColor {
	return [UIColor colorWithHue:220.0 saturation:.06 brightness:.40 alpha:1.0];
}

+ (UIFont *)stackOverflowUserBadgeCountFont {
	return [[self baseLightFont] fontWithSize:12.5];
}

+ (UIColor *)stackOverflowUserBadgeCountColor {
	return [UIColor colorWithHue:200.0 saturation:.02 brightness:.58 alpha:1.0];
}

@end

NS_ASSUME_NONNULL_END
