//
//  KRStackOverflowApiManager.m
//  wag-ios-challenge
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

#import "KRStackOverflowApiManager.h"

// domain model
#import "KRStackOverflowUser.h"

NS_ASSUME_NONNULL_BEGIN

@implementation KRStackOverflowApiManager
// common
static NSString *const KRParamSiteKey = @"site";

// stack overflow
static NSString *const KRParamSiteValueStackOverflow = @"stackoverflow";

// users
static NSString *const KRUsersJsonUsersKey = @"items";
// ----

#pragma mark - Users

- (void)fetchUsersWithCompletion:(KRStackOverflowApiManagerUsersFetchCompletion)completion {
	NSString *const kUrlString = @"https://api.stackexchange.com/2.2/users";

	// params
	NSDictionary *params =
	@{ KRParamSiteKey	: KRParamSiteValueStackOverflow };

	[self GET:kUrlString parameters:params progress:nil
	  success:^(NSURLSessionDataTask *task, id _Nullable responseObject) {
		  //NSLog(@"GET users success, response: %@", responseObject);
		  if (![responseObject isKindOfClass:[NSDictionary class]]) {
			  NSString *errorMsg = [NSString stringWithFormat:@"Expected response object to be an NSDictionary, was '%@'", responseObject];
			  NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:@{ NSLocalizedDescriptionKey : errorMsg }];
			  completion(@[], error);
			  return;
		  }
		  NSDictionary *responseDict = (NSDictionary *)responseObject;

		  NSArray *items = [responseDict objectForKey:KRUsersJsonUsersKey];
		  if (!items) {
			  NSString *errorMsg = @"Couldn't find items (users) key in JSON response.";
			  NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:@{ NSLocalizedDescriptionKey : errorMsg }];
			  completion(@[], error);
			  return;
		  }

		  // convert response to models
		  NSMutableArray<KRStackOverflowUser *> *mutaUsers = [NSMutableArray new];
		  for (id jsonObject in items) {
			  if (![jsonObject isKindOfClass:[NSDictionary class]]) {
				  NSString *errorMsg = [NSString stringWithFormat:@"Expected an NSDictionary in converting user items to models but was '%@'", [jsonObject class]];
				  NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:@{ NSLocalizedDescriptionKey : errorMsg }];
				  completion(@[], error);
				  return;
			  }
			  NSDictionary *jsonDict = (NSDictionary *)jsonObject;

			  KRStackOverflowUser *user = [[KRStackOverflowUser alloc] initWithJsonDictionary:jsonDict];
			  [mutaUsers addObject:user];
		  }

		  completion([mutaUsers copy], nil);
	  }
	  failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
		  //NSLog(@"GET users fail, error: %@", error);
		  id urlResponseObject = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
		  if (!urlResponseObject) {
			  completion(@[], error);
			  return;
		  }
		  if (![urlResponseObject isKindOfClass:[NSHTTPURLResponse class]]) {
			  NSString *errorMsg = [NSString stringWithFormat:@"Expected NSHTTPUrlResponse response object, but was '%@'", urlResponseObject];
			  NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:@{ NSLocalizedDescriptionKey : errorMsg }];
			  completion(@[], error);
			  return;

		  }
		  NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)urlResponseObject;
		  NSLog(@"Failure status code is %li", urlResponse.statusCode);
		  completion(@[], error);
	  }];
}

#pragma mark - Start / End

- (instancetype)init {
	if (self = [self initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]]) {
		self.requestSerializer = [AFJSONRequestSerializer serializer];
	}
	return self;
}

@end

NS_ASSUME_NONNULL_END
