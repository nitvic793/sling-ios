//
//  GTableViewCell.m
//  grofer-consumer
//
//  Created by Satyam Krishna on 16/12/14.
//  Copyright (c) 2014 GroferIt. All rights reserved.
//

#import "STableViewCell.h"

@implementation STableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        CGRect frame = self.frame;
        frame.size.width = [CommonFunction getPhoneWidth];
        [self setFrame:frame];
        
        CGRect containerFrame = self.contentView.frame;
        containerFrame.size.width = [CommonFunction getPhoneWidth];
        [self.contentView setFrame:containerFrame];
    }
    return self;
}


@end
