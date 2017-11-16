//
//  KRStackOverflowApiManagerTest.m
//  ios-stack-overflow
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KRStackOverflowApiManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface KRStackOverflowApiManagerTest : XCTestCase
@property (nonatomic, strong) XCTestExpectation *expFetchUsers;

@property (nonatomic, strong) KRStackOverflowApiManager *apiManager;
@end

@implementation KRStackOverflowApiManagerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFetchUsers {
	self.expFetchUsers = [self expectationWithDescription:@"expect to fetch users"];
	self.apiManager = [KRStackOverflowApiManager new];
	[self.apiManager fetchUsersWithCompletion:^(NSArray<id> * _Nonnull users, NSError * _Nullable error) {
		NSLog(@"users: %@", users);
		XCTAssertTrue(users.count > 0);
		[self.expFetchUsers fulfill];
	}];

	[self waitForExpectationsWithTimeout:5.0 handler:^(NSError * _Nullable error) {
	}];
}

@end

NS_ASSUME_NONNULL_END
