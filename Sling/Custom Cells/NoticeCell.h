//
//  NoticeCell.h
//  Sling
//
//  Created by Satyam Krishna on 28/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "STableViewCell.h"
#import "Notice.h"

@interface NoticeCell : STableViewCell

-(void) updateCellForNotice:(Notice *) notice;
+(CGFloat) cellHeightForNotice:(Notice *) notice;

@end
