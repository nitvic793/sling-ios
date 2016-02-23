//
//  ClassNumber.h
//  Sling
//
//  Created by Prince S. Valluri on 1/21/16.
//  Copyright © 2016 Sling. All rights reserved.
//

#import "BaseObject.h"
#import "Teacher.h"

@interface ClassNumber : BaseObject

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *deprecationDate;
@property (nonatomic, strong) NSString *room;
@property (nonatomic, strong) Teacher *teacher;

@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

@end
