//
//  ClassRoom.h
//  Sling
//
//  Created by Satyam Krishna on 27/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "BaseObject.h"
#import "Teacher.h"

@interface ClassRoom : BaseObject

@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *room;
@property (nonatomic, strong) Teacher *teacher;

@property (nonatomic, strong) NSString *deprecationDate;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;


@end
