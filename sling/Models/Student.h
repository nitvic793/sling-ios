//
//  Student.h
//  Sling
//
//  Created by Prince S. Valluri on 1/21/16.
//  Copyright © 2016 Sling. All rights reserved.
//

#import "BaseObject.h"
#import "ClassNumber.h"
#import "Parent.h"
#import "Review.h"

@interface Student : BaseObject

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *dob;
@property (nonatomic, strong) NSString *identificationNumber;
@property (nonatomic, strong) NSArray *classes; // Collection of ClassNumber
@property (nonatomic, strong) NSArray *parents; // Collection of Parent
@property (nonatomic, strong) NSArray *reviews; // Collection of Reviews

@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

@end
