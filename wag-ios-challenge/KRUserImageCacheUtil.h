//
//  KRUserImageCacheUtil.h
//  wag-ios-challenge
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIImage;

typedef void (^KRUserImageCacheFetchImageCompletion)(UIImage *_Nullable image);

@interface KRUserImageCacheUtil : NSObject

#pragma mark - Cache Operations
+ (nullable UIImage *)fastCachedImageForUrl:(NSURL *)url;

// checks disk cache, else fetches from network (and caches it)
+ (void)slowCachedImageForUrl:(NSURL *)url
				   completion:(KRUserImageCacheFetchImageCompletion)completion;

+ (void)clearInMemoryCache;
+ (void)clearDiskCache;

#pragma mark - URL Cache
+ (void)setUpUrlCache;
@end

NS_ASSUME_NONNULL_END
