//
//  NoticeBoardApi.m
//  Sling
//
//  Created by Satyam Krishna on 27/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "NoticeBoardApi.h"
#import "Notice.h"

@implementation NoticeBoardApi

@synthesize notices;

-(id) init
{
    self = [super init];
    if (self)
    {
        notices = [NSMutableArray array];
    }
    return self;
}

-(void) fetchAllNoticesWithCompletion:(SimpleErrorCompletionBlock)block
{
    [[APIManager sharedManager] sendOperationForURL:@"/noticeboard/"
                                          andMethod:HTTP_GET
                                         andHeaders:nil
                                          andParams:nil
                                            andBody:nil
                                    andSuccessBlock:^(id responseObject) {
                                        [self parseObjectForNotices:responseObject withInitialParams:nil];
                                        block(nil);
                                    }
                                    andFailureBlock:^(NSCustomError *error) {
                                        block(error);
                                    }];
}

-(void) parseObjectForNotices:(NSDictionary *)responseObject withInitialParams:(NSDictionary *)params
{
    notices = [NSMutableArray array];
    for (NSMutableDictionary *noticeDict in responseObject) {
        Notice *notice = [[Notice alloc] init];
        [notice parseObject:noticeDict withInitialParams:params];
        [notices addObject:notice];
    }
}

@end
