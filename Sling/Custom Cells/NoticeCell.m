//
//  NoticeCell.m
//  Sling
//
//  Created by Satyam Krishna on 28/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "NoticeCell.h"

@implementation NoticeCell
{
    UIView *container;
    
    UILabel *classRoomLabel;
    UILabel *classRoomTitleLabel;
    UILabel *classRoomMessage;
    UIView *seperator;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [[self contentView] setBackgroundColor:UIColorFromRGB(LOADING_BG_COLOR)];
        
        container = [[UIView alloc] init];
        [container setBackgroundColor:UIColorFromRGB(WHITE_COLOR)];
        [[container layer] setCornerRadius:2.0f];
        [[container layer] setMasksToBounds:YES];
        
        classRoomLabel = [[UILabel alloc] init];
        [classRoomLabel setFont:FONT_BOLD_14];
        
        classRoomTitleLabel = [[UILabel alloc] init];
        [classRoomTitleLabel setFont:FONT_REGULAR_12];
        
        seperator = [[UIView alloc] init];
        [seperator setBackgroundColor:UIColorFromRGB(SEPARATOR_COLOR_LIGHT)];
        
        classRoomMessage = [[UILabel alloc] init];
        [classRoomMessage setFont:FONT_BODY];
        [classRoomMessage setNumberOfLines:0];

        [container addSubview:classRoomLabel];
        [container addSubview:classRoomTitleLabel];
        [container addSubview:seperator];
        [container addSubview:classRoomMessage];
        
        [[self contentView] addSubview:container];
    }
    return self;
}

-(void) updateCellForNotice:(Notice *) notice
{
    int cellHeight = [NoticeCell cellHeightForNotice:notice];
    int messageHeight = [NoticeCell cellHeightForNoticeMessage:notice];

    [classRoomLabel setText:[NSString stringWithFormat:@"Class %@ - %@",[[notice classRoom] room], [[notice classRoom] subject]]];
    [classRoomTitleLabel setText:[notice title]];
    [classRoomMessage setText:[notice message]];

    [container setFrame:CGRectMake(SIDE_PADDING, SIDE_PADDING, [CommonFunction getPhoneWidth] - 2*SIDE_PADDING, cellHeight - 2*SIDE_PADDING)];
    [classRoomLabel setFrame:CGRectMake(SIDE_PADDING, SIDE_PADDING/2, W(container)-2*SIDE_PADDING, 20)];
    [classRoomTitleLabel setFrame:CGRectMake(SIDE_PADDING, BOTTOM(classRoomLabel), W(container)-2*SIDE_PADDING, 15)];
    [seperator setFrame:CGRectMake(SIDE_PADDING, BOTTOM(classRoomTitleLabel) + 2, W(container) - 2*SIDE_PADDING, TABLE_VIEW_SEPARATOR_HEIGHT)];
    [classRoomMessage setFrame:CGRectMake(SIDE_PADDING, BOTTOM(seperator)+2, W(container) - 2*SIDE_PADDING, messageHeight)];
}

+(CGFloat) cellHeightForNoticeMessage:(Notice *) notice
{
    CGRect message_rect = [[notice message] boundingRectWithSize:CGSizeMake([CommonFunction getPhoneWidth] - 4*SIDE_PADDING, MAXFLOAT)
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName:FONT_BODY}
                                                         context:nil];
    
    return message_rect.size.height;
}

+(CGFloat) cellHeightForNotice:(Notice *) notice
{
    int messageHeight = [NoticeCell cellHeightForNoticeMessage:notice];
    return SIDE_PADDING + SIDE_PADDING/2 + 20 + 15 + 2 + TABLE_VIEW_SEPARATOR_HEIGHT + 2 + messageHeight + SIDE_PADDING/2 + SIDE_PADDING;
}

@end
