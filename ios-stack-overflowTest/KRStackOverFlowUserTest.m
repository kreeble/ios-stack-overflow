//
//  KRStackOverFlowUserTest.m
//  ios-stack-overflow
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

#import <XCTest/XCTest.h>

// domain model
#import "KRStackOverflowUser.h"
#import "KRStackOverflowUserBadgeCounts.h"

NS_ASSUME_NONNULL_BEGIN

@interface KRStackOverFlowUserTest : XCTestCase

@end

@implementation KRStackOverFlowUserTest

- (void)setUp {
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}

- (void)testCreateWithJson {
	NSString *userJson = @"{\"badge_counts\":{\"bronze\": 7868,\"silver\": 7085,\"gold\": 569},\"reputation\": 963731, \"user_id\": 22656,\"profile_image\": \"https://www.gravatar.com/avatar/6d8ebb117e8d83d74ea95fbdd0f87e13?s=128&d=identicon&r=PG\",\"display_name\": \"Jon Skeet\"}";
	NSData *userJsonData = [userJson dataUsingEncoding:NSUTF8StringEncoding];
	NSError *error = nil;
	NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:userJsonData options:0 error:&error];
	if (error) {
		XCTAssert(false);
	}

	KRStackOverflowUser *user = [[KRStackOverflowUser alloc] initWithJsonDictionary:jsonDict];
	XCTAssertEqual(user.userId, 22656);
	XCTAssertEqual(user.reputation, 963731);
	XCTAssertEqualObjects(user.displayName, @"Jon Skeet");
	XCTAssertEqualObjects(user.profileImage,
						  [NSURL URLWithString:@"https://www.gravatar.com/avatar/6d8ebb117e8d83d74ea95fbdd0f87e13?s=128&d=identicon&r=PG"]);
	XCTAssertEqual(user.badgeCounts.bronze, 7868);
	XCTAssertEqual(user.badgeCounts.silver, 7085);
	XCTAssertEqual(user.badgeCounts.gold, 569);
	NSLog(@"%@", user);
}

@end

NS_ASSUME_NONNULL_END
