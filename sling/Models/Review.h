//
//  Review.h
//  Sling
//
//  Created by Prince S. Valluri on 1/21/16.
//  Copyright © 2016 Sling. All rights reserved.
//

#import "BaseObject.h"
#import "ClassRoom.h"

@class Student;

@interface Review : BaseObject

@property (nonatomic, strong) NSString *review;
@property (nonatomic, strong) ClassRoom *classNumber;
@property (nonatomic, strong) Student *student;

@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

@end
