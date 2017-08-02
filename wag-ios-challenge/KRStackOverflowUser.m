//
//  KRStackOverflowUser.m
//  wag-ios-challenge
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

#import "KRStackOverflowUser.h"
#import "KRStackOverflowUserBadgeCounts.h"

NS_ASSUME_NONNULL_BEGIN

@implementation KRStackOverflowUser

#pragma mark - Start / End

- (instancetype)init {
	return [self initWithJsonDictionary:@{}];
}

// note: ideally we would create our own generic JSON de/serializer library that
// uses reflection to fill an instance's properties with values from the JSON,
// or use a library like JSONModel. for time and scope,
// we will manually populate our class' properties from the JSON.
- (instancetype)initWithJsonDictionary:(NSDictionary *)json {
	if (self = [super init]) {
		[self setUpWithJsonDictionary:json];
	}
	return self;
}

- (void)setUpWithJsonDictionary:(NSDictionary *)jsonDict {
	NSString *userIdJson = [jsonDict objectForKey:@"user_id"];
	_userId = (userIdJson ? [userIdJson integerValue] : 0);

	NSString *reputationJson = [jsonDict objectForKey:@"reputation"];
	_reputation = (reputationJson ? [reputationJson integerValue] : 0);

	NSString *displayNameJson = [jsonDict objectForKey:@"display_name"];
	_displayName = (displayNameJson ? [displayNameJson copy] : @"");

	NSString *profileImageJson = [jsonDict objectForKey:@"profile_image"];
	_profileImage = [NSURL URLWithString:profileImageJson]; // works with nil url string

	KRStackOverflowUserBadgeCounts *badgeCounts = [KRStackOverflowUserBadgeCounts new];
	_badgeCounts = badgeCounts;
	NSDictionary *badgeCountsJson = [jsonDict objectForKey:@"badge_counts"];
	if (badgeCountsJson) {
		NSString *bronzeJson = [badgeCountsJson objectForKey:@"bronze"];
		badgeCounts.bronze = [bronzeJson integerValue];
		NSString *silverJson = [badgeCountsJson objectForKey:@"silver"];
		badgeCounts.silver = [silverJson integerValue];
		NSString *goldJson = [badgeCountsJson objectForKey:@"gold"];
		badgeCounts.gold = [goldJson integerValue];
	}
}

- (NSString *)description {
	return [NSString stringWithFormat:@"{userId = %lu, reputation = %lu, displayName = '%@', profileImage = '%@', badgeCounts = '%@'}", (unsigned long)self.userId, (unsigned long)self.reputation, self.displayName, self.profileImage, self.badgeCounts];
}

@end

NS_ASSUME_NONNULL_END
