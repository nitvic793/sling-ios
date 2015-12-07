//
//  GImageSlider.m
//  grofer-consumer
//
//  Created by Prince Shekhar Valluri on 25/05/15.
//  Copyright (c) 2015 GroferIt. All rights reserved.
//

#import "ImageSlider.h"

@implementation ImageSlider
{
    NSArray *sliderImages;
    UIScrollView *mainScrollView;
    UIView *seperator;
    UIPageControl *pageControl;
    UIViewContentMode imageContentMode;
    CGFloat sidePad;
}

- (id)initWithFrame:(CGRect)frame andImages:(NSArray *)images andContentMode:(UIViewContentMode)contentMode andSidePadding:(CGFloat)sidePadding;
{
    self = [super initWithFrame:frame];
    if (self)
    {
        sliderImages = images;
        imageContentMode = contentMode;
        sidePad = sidePadding;
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, W(self), H(self) - 40)];
    [mainScrollView setDelegate:self];
    [mainScrollView setPagingEnabled:YES];
    [mainScrollView setShowsHorizontalScrollIndicator:NO];
    [mainScrollView setShowsVerticalScrollIndicator:NO];
    [self addSubview:mainScrollView];
    
    double xOffset = 0.0;
    for (NSString *image in sliderImages)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(xOffset+sidePad, 0, W(mainScrollView)-2*sidePad, H(mainScrollView))];
        [imgView setGImageWithURL:[NSURL URLWithString:image] placeholderImage:IMG(PLACEHOLDER_IMG_DETAILS) andLoadingColor:UIColorFromRGB(WHITE_COLOR)];
        [imgView setContentMode:imageContentMode];
        [mainScrollView addSubview:imgView];
        
        xOffset += W(mainScrollView);
    }
    
    [mainScrollView setContentSize:CGSizeMake(xOffset, H(mainScrollView))];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, H(self) - 30, W(self), 20)];
    [pageControl setCurrentPageIndicatorTintColor:UIColorFromRGB(GROFERS_ORANGE)];
    [pageControl setPageIndicatorTintColor:UIColorFromRGB(GBL4)];
    [pageControl setHidesForSinglePage:YES];
    [pageControl setNumberOfPages:sliderImages.count];
    [pageControl addTarget:self action:@selector(pageControlClicked) forControlEvents:UIControlEventTouchUpInside];

    seperator = [[UIView alloc] initWithFrame:CGRectMake(0, H(self) - SEPARATOR_THINNEST, [CommonFunction getPhoneWidth], SEPARATOR_THINNEST)];
    [seperator setBackgroundColor:UIColorFromRGB(SEPARATOR_COLOR)];
        
    [self addSubview:seperator];
    [self addSubview:pageControl];
}

-(void) pageControlClicked
{
    [mainScrollView setContentOffset:CGPointMake(W(mainScrollView)*[pageControl currentPage], mainScrollView.contentOffset.y) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    pageControl.currentPage = lround(scrollView.contentOffset.x / W(scrollView));
}

- (void)setCurrentPageTintColor:(UIColor *)color1 andOtherPagesTintColor:(UIColor *)color2
{
    [pageControl setCurrentPageIndicatorTintColor:color1];
    [pageControl setPageIndicatorTintColor:color2];
}

@end
