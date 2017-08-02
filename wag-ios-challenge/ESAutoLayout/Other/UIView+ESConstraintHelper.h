//
//  UIView+KRConstraintHelper.h
//  MusicFree
//
//  Created by kreeble on 8/29/14.
//  Copyright (c) 2014 kreeble. All rights reserved.
//
//  Original code from Erica Sadun's iOS Cookbook
//  Source: https://github.com/erica/iOS-7-Cookbook/tree/master/C05%20Constraints/06%20-%20Describing%20Constraints
//

@import UIKit;

@interface UIView (ESConstraintHelper)

#pragma mark - Constraint Management
- (BOOL)constraint:(NSLayoutConstraint *)constraintA matches:(NSLayoutConstraint *)constraintB;
- (NSLayoutConstraint *)constraintMatchingConstraint:(NSLayoutConstraint *)aConstraint;
- (void)removeMatchingConstraint:(NSLayoutConstraint *)aConstraint;
- (void)removeMatchingConstraints:(NSArray *)anArray;

#pragma mark - Superview-related Constraints
- (NSArray *)constraintsLimitingViewToSuperviewBounds;
- (void)constrainWithinSuperviewBounds;
- (void)addSubviewAndConstrainToBounds:(UIView *)view;

#pragma mark - Size & Position
- (NSArray *)sizeConstraints:(CGSize)aSize;
- (NSArray *)positionConstraints: (CGPoint)aPoint;
- (void)constrainSize:(CGSize)aSize;
- (void)constrainPosition: (CGPoint)aPoint; // w/in superview bounds

#pragma mark - Centering
- (NSLayoutConstraint *)horizontalCenteringConstraint;
- (NSLayoutConstraint *)verticalCenteringConstraint;
- (void)centerHorizontallyInSuperview;
- (void)centerVerticallyInSuperview;
- (void)centerInSuperview;

#pragma mark - Aspect Ratios
- (NSLayoutConstraint *)aspectConstraint:(CGFloat)aspectRatio;
- (void)constrainAspectRatio:(CGFloat)aspectRatio;

#pragma mark - Debugging & Logging
- (NSString *)constraintRepresentation:(NSLayoutConstraint *)aConstraint;
- (void)showConstraints;

@end