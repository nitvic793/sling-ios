//
//  Notice.h
//  Sling
//
//  Created by Satyam Krishna on 27/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "BaseObject.h"
#import "ClassRoom.h"

@interface Notice : BaseObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *notice;
@property (nonatomic, strong) ClassRoom *classNumber;

@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;


@end
