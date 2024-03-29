//
//  Parent.h
//  Sling
//
//  Created by Prince S. Valluri on 1/21/16.
//  Copyright © 2016 Sling. All rights reserved.
//

#import "BaseObject.h"

@interface Parent : BaseObject

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *relationship;

@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;

@end
