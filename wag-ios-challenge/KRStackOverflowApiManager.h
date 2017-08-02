//
//  KRStackOverflowApiManager.h
//  wag-ios-challenge
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^KRStackOverflowApiManagerUsersFetchCompletion)(NSArray<id> *users, NSError * _Nullable error);

@interface KRStackOverflowApiManager : AFHTTPSessionManager

#pragma mark - Users
- (void)fetchUsersWithCompletion:(KRStackOverflowApiManagerUsersFetchCompletion)completion;
@end

NS_ASSUME_NONNULL_END
