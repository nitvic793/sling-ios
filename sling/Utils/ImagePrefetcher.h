//
//  GImagePrefetcher.h
//  grofer-consumer
//
//  Created by Parul Jaisansaria on 06/10/15.
//  Copyright © 2015 GroferIt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImagePrefetcher : NSObject

+ (ImagePrefetcher*)sharedImageManager;

-(void) addURL:(NSString *) url;
-(void) preFetchAll;

@end
