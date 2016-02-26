//
//  NoticeBoardApi.h
//  Sling
//
//  Created by Satyam Krishna on 27/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "BaseObject.h"
#import "APIManager.h"

@interface NoticeBoardApi : BaseObject

@property (nonatomic, strong) NSMutableArray *notices;

-(void) fetchAllNoticesWithCompletion:(SimpleErrorCompletionBlock)block;

@end
