//
//  NoticeBoardViewController.m
//  Sling
//
//  Created by Satyam Krishna on 24/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import "NoticeBoardViewController.h"

@implementation NoticeBoardViewController

-(id) init
{
    self = [super init];
    if (self)
    {
        [[self view] setBackgroundColor:[CommonFunction getRandomColor]];
    }
    return self;
}

@end
