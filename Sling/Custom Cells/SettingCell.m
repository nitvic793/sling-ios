//
//  SettingCell.m
//  Sling
//
//  Created by Satyam Krishna on 27/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell
{
    UILabel *nameLabel;
    UIView *seperator;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        nameLabel = [[UILabel alloc] init];
        [nameLabel setFont:FONT_REGULAR_14];
        
        seperator = [[UILabel alloc] init];
        [seperator setBackgroundColor:UIColorFromRGB(TABLE_VIEW_SEPARATOR_COLOR)];
        
        [[self contentView] addSubview:nameLabel];
        [[self contentView] addSubview:seperator];
    }
    return self;
}
-(void) setText:(NSString*) text
{
    [nameLabel setText:text];
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [nameLabel setFrame:CGRectMake(SIDE_PADDING, 0, W([self contentView]) - 2*SIDE_PADDING, [SettingCell cellHeight])];
    [seperator setFrame:CGRectMake(0, [SettingCell cellHeight]- TABLE_VIEW_SEPARATOR_HEIGHT, W([self contentView]), TABLE_VIEW_SEPARATOR_HEIGHT)];
}

+(float) cellHeight
{
    return 40;
}
@end
