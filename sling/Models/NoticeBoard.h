//
//  NoticeBoard.h
//  Sling
//
//  Created by Prince S. Valluri on 1/21/16.
//  Copyright © 2016 Sling. All rights reserved.
//

#import "BaseObject.h"
#import "ClassNumber.h"

@interface NoticeBoard : BaseObject

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *notice;
@property (nonatomic, strong) ClassNumber *classNumber;

@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

@end
