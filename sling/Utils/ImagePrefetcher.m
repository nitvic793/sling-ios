//
//  GImagePrefetcher.m
//  grofer-consumer
//
//  Created by Parul Jaisansaria on 06/10/15.
//  Copyright © 2015 GroferIt. All rights reserved.
//

#import "ImagePrefetcher.h"
#import "SDWebImagePrefetcher.h"

@implementation ImagePrefetcher
{
    NSMutableArray *images;
}

static ImagePrefetcher *sharedInstance = nil;

-(id) init
{
    self = [super init];
    if (self)
    {
        images = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (ImagePrefetcher*)sharedImageManager
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        sharedInstance = [[super alloc] init];
    });
    
    return sharedInstance;
}

-(void) addURL:(NSString *)url
{
    if (url && [url length] > 0)
    {
        [images addObject:[NSURL URLWithString:url]];
    }
}

-(void) preFetchAll
{
    [[SDWebImagePrefetcher sharedImagePrefetcher] prefetchURLs:[NSMutableArray arrayWithArray:images]];
    
    images = [[NSMutableArray alloc] init];
}


@end
