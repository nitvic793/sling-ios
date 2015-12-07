//
//  UIImageView+CommonFunction.h
//  grofer-consumer
//
//  Created by Prince Shekhar Valluri on 22/05/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+AFNetworking.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UIImageView (CommonFunction)

- (void)setGImageWithURL:(NSURL *)url;

- (void)setGImageWithURL:(NSURL *)url
        placeholderImage:(UIImage *)placeholderImage;

- (void)setGImageWithURLRequest:(NSURLRequest *)urlRequest
               placeholderImage:(UIImage *)placeholderImage
                        success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                        failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure;


- (void)setGImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage andLoadingColor:(UIColor *) color;


@end
