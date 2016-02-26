//
//  Teacher.h
//  Sling
//
//  Created by Prince S. Valluri on 1/21/16.
//  Copyright © 2016 Sling. All rights reserved.
//

#import "BaseObject.h"

@interface Teacher : BaseObject

@property (nonatomic, strong) NSDate *employmentStartDate;
@property (nonatomic, strong) NSString *employeeNumber;
@property (nonatomic, strong) NSString *department;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

@end
