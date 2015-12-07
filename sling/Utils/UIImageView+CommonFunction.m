//
//  UIImageView+CommonFunction.m
//  grofer-consumer
//
//  Created by Prince Shekhar Valluri on 22/05/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import "UIImageView+CommonFunction.h"
#import "SettingsManager.h"
#import "CommonFunction.h"

@implementation UIImageView (CommonFunction)

- (void)setGImageWithURL:(NSURL *)url
{
    __weak __typeof(self)wself = self;
    
    if ([[SettingsManager sharedManager] isImagesDisbaled])
    {
        [wself setImage:nil];
        return;
    }
    
    [self setGImageWithURL:url placeholderImage:nil];
}

- (void)setGImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage andLoadingColor:(UIColor *) color
{
    __weak __typeof(self)wself = self;
    
    if ([[SettingsManager sharedManager] isImagesDisbaled])
    {
        [wself setImage:placeholderImage];
        return;
    }
    
    [wself sd_setImageWithURL:url placeholderImage:[CommonFunction imageWithColor:color] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (error)
        {
            [wself setImage:placeholderImage];
        }

    }];
    
}

- (void)setGImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage
{
    __weak __typeof(self)wself = self;
    
    if ([[SettingsManager sharedManager] isImagesDisbaled])
    {
        [wself setImage:placeholderImage];
        return;
    }
    
    [wself sd_setImageWithURL:url placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
    {
        
    }];
    
    //    [wself sd_setImageWithURL:url placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //        if (cacheType == SDImageCacheTypeNone) {
    //            wself.alpha = 0;
    //            [UIView animateWithDuration:0.5 animations:^{
    //                wself.alpha = 1;
    //            }];
    //        } else {
    //            wself.alpha = 1;
    //        }
    //    }];
}


- (void)setGImageWithURLRequest:(NSURLRequest *)urlRequest
               placeholderImage:(UIImage *)placeholderImage
                        success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                        failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure
{
    if ([[SettingsManager sharedManager] isImagesDisbaled])
    {
        [self setImage:placeholderImage];
        return;
    }
    
    [self setImageWithURLRequest:urlRequest placeholderImage:placeholderImage success:success failure:failure];
}

@end
