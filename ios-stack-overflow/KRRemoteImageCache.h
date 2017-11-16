//
//  KRRemoteImageCache.h
//  ios-stack-overflow
//
//  Created by kreeble on 8/1/17.
//  Copyright © 2017 kreeble. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIImage;

typedef void (^KRRemoteImageCacheFetchCompletion)(UIImage *_Nullable image);

@interface KRRemoteImageCache : NSObject

#pragma mark - Cache Operations
+ (nullable UIImage *)fastCachedImageForUrl:(NSURL *)url;

// checks disk cache, else fetches from network (and caches it)
+ (void)slowCachedImageForUrl:(NSURL *)url
				   completion:(KRRemoteImageCacheFetchCompletion)completion;

+ (void)clearInMemoryCache;
+ (void)clearDiskCache;
@end

NS_ASSUME_NONNULL_END
