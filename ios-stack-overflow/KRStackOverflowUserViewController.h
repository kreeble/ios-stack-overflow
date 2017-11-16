//
//  KRStackOverflowUserViewController.h
//  ios-stack-overflow
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KRStackOverflowUser;

@interface KRStackOverflowUserViewController : UITableViewController
// users
@property (nonatomic, copy, readonly) NSArray<KRStackOverflowUser *> *users;
@end

NS_ASSUME_NONNULL_END
