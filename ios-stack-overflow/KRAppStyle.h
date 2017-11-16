//
//  KRAppStyle.h
//  ios-stack-overflow
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

// ideally we would have an abstract style class with various concrete subclasses
@interface KRAppStyle : NSObject

#pragma mark - Generic
+ (UIFont *)baseFont;
+ (UIFont *)baseLightFont;
+ (UIFont *)baseBoldFont;

#pragma mark - SO User Cell
+ (UIFont *)stackOverflowUserNameFont;
+ (UIColor *)stackOverflowUserNameColor;
+ (UIFont *)stackOverflowUserReputationFont;
+ (UIColor *)stackOverflowUserReputationColor;
+ (UIFont *)stackOverflowUserBadgeCountFont;
+ (UIColor *)stackOverflowUserBadgeCountColor;
@end

NS_ASSUME_NONNULL_END
