//
//  User.h
//  Sling
//
//  Created by Prince S. Valluri on 1/21/16.
//  Copyright © 2016 Sling. All rights reserved.
//

#import "BaseObject.h"
#import "Parent.h"
#import "Teacher.h"

@interface User : BaseObject

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) Parent *parent;
@property (nonatomic, strong) Teacher *teacher;

@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

@end
