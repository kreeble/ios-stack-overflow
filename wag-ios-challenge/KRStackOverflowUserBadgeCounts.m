//
//  KRStackOverflowUserBadgeCounts.m
//  wag-ios-challenge
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

#import "KRStackOverflowUserBadgeCounts.h"

NS_ASSUME_NONNULL_BEGIN

@implementation KRStackOverflowUserBadgeCounts

- (NSString *)description {
	return [NSString stringWithFormat:@"{bronze = '%lu', silver = '%lu', gold = '%lu'}", self.bronze, self.silver, self.gold];
}

@end

NS_ASSUME_NONNULL_END
