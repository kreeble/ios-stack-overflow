//
//  KRStackOverflowUser.h
//  ios-stack-overflow
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KRStackOverflowUserBadgeCounts;

NS_ASSUME_NONNULL_BEGIN

@interface KRStackOverflowUser : NSObject

@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, assign) NSUInteger reputation;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy, nullable) NSURL *profileImage;

@property (nonatomic, strong) KRStackOverflowUserBadgeCounts *badgeCounts;

#pragma mark - Start / End
- (instancetype)initWithJsonDictionary:(NSDictionary *)json NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
