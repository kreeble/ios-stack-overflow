//
//  KRStackOverflowUserBadgeCounts.m
//  ios-stack-overflow
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

#import "KRStackOverflowUserBadgeCounts.h"

NS_ASSUME_NONNULL_BEGIN

@implementation KRStackOverflowUserBadgeCounts

- (NSString *)description {
	return [NSString stringWithFormat:@"{bronze = '%lu', silver = '%lu', gold = '%lu'}", (unsigned long)self.bronze, (unsigned long)self.silver, (unsigned long)self.gold];
}

@end

NS_ASSUME_NONNULL_END
