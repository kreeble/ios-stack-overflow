//
//  KRRemoteImageCache.m
//  ios-stack-overflow
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

#import "KRRemoteImageCache.h"
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@implementation KRRemoteImageCache

static NSString *const KRCacheDiskPath = @"KRRemoteImageCache";

// units
#define KRMegaByte	(1024 * 1024)
// ----

#pragma mark - Cache Operations

+ (nullable UIImage *)fastCachedImageForUrl:(NSURL *)url {
	return [[self inMemoryCache] objectForKey:url];
}

+ (void)slowCachedImageForUrl:(NSURL *)url
				   completion:(KRRemoteImageCacheFetchCompletion)completion
{
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
		// check disk cache
		NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
		NSURLCache *urlCache = [self urlCache];
		NSCachedURLResponse *cachedUrlResponse = [urlCache cachedResponseForRequest:urlRequest];
		if (cachedUrlResponse) {
			NSLog(@"disk cache hit for '%@'", url);
			NSData *data = cachedUrlResponse.data;
			UIImage *image = [UIImage imageWithData:data];
			[self cacheInMemoryForUrl:url image:image];

			dispatch_async(dispatch_get_main_queue(), ^{
				completion(image);
			});
			return;
		}

		// fetch from network
		NSLog(@"fetching image from network for '%@'", url);
		NSURLSession *urlSession = [self urlSession];
		NSURLSessionDataTask *dataTask = [urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
		{
			UIImage *image = nil;
			if (data != nil) {
				image = [UIImage imageWithData:data];
				[self cacheInMemoryForUrl:url image:image];
				// cached in disk automatically through NSURLSession
			}

			dispatch_async(dispatch_get_main_queue(), ^{
				completion(image);
			});
		}];
		[dataTask resume];
	});
}

+ (void)clearInMemoryCache {
	[[self inMemoryCache] removeAllObjects];
}

+ (void)clearDiskCache {
	[[self urlCache] removeAllCachedResponses];
}

#pragma mark - In-Memory Cache

+ (void)cacheInMemoryForUrl:(NSURL *)url image:(UIImage *)image {
	[[self inMemoryCache] setObject:image forKey:[url copy]];
}

+ (NSCache *)inMemoryCache {
	static dispatch_once_t onceToken;
	static NSCache *_cache = nil;
	dispatch_once(&onceToken, ^{
		_cache = [[NSCache alloc] init];
	});
	return _cache;
}

#pragma mark - URL Cache

+ (NSURLCache *)urlCache {
	static dispatch_once_t onceToken;
	static NSURLCache *_urlCache = nil;
	dispatch_once(&onceToken, ^{
		_urlCache = [[NSURLCache alloc] initWithMemoryCapacity:0 * KRMegaByte
												  diskCapacity:50 * KRMegaByte
													  diskPath:KRCacheDiskPath];
	});
	return _urlCache;
}

#pragma mark - NSURLSession

+ (NSURLSession *)urlSession {
	static dispatch_once_t onceToken;
	static NSURLSession *_urlSession = nil;
	dispatch_once(&onceToken, ^{
		NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
		sessionConfig.URLCache = [self urlCache];
		sessionConfig.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
		NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfig];
		_urlSession = urlSession;
	});
	return _urlSession;
}

@end

NS_ASSUME_NONNULL_END
