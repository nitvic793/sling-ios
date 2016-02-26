//
//  NoResourceView.h
//  Sling
//
//  Created by Satyam Krishna on 27/02/16.
//  Copyright © 2016 Bitstax. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoResourceViewDelegate <NSObject>

@optional
- (void) noResourceButtonClicked:(NSUInteger) tag;

@end

@interface NoResourceView : UIView

@property (nonatomic,retain) IBOutlet UIImageView *iconImg;
@property (nonatomic,retain) IBOutlet UILabel *iconLabel;
@property (nonatomic,retain) IBOutlet UILabel *mainLabel;
@property (nonatomic,retain) IBOutlet UILabel *subLabel;
@property (nonatomic,retain) IBOutlet UIButton *button;
@property (nonatomic) id<NoResourceViewDelegate> delegate;
@property (nonatomic) CGSize imgSize;

-(id) initWithIconText:(NSString *) iconText andMainText:(NSString *) mainText andSubText:(NSString *) subText andButtonText:(NSString *) buttonText;
-(id) initWithIconText:(NSString *) iconText andMainText:(NSString *) mainText andSubAttrText:(NSAttributedString *) subText andButtonText:(NSString *) buttonText;
-(id) initWithIconText:(NSString *) iconText andMainText:(NSString *) mainText andSubText:(NSString *) subText andButtonText:(NSString *) buttonText andTag:(NSUInteger) tag;
-(id) initWithIconText:(NSString *) iconText andMainText:(NSString *) mainText andSubAttrText:(NSAttributedString *) subText andButtonText:(NSString *) buttonText andTag:(NSUInteger) tag;
-(id) initWithIconImg:(UIImage *) icon andMainText:(NSString *) mainText andSubText:(NSString *) subText andButtonText:(NSString *) buttonText andImgSize:(CGSize) img_size;
-(id) initWithIconImg:(UIImage *) icon andMainText:(NSString *) mainText andSubAttrText:(NSAttributedString *) subText andButtonText:(NSString *) buttonText;

-(void) setButtonVisibility:(BOOL) visible;

@end
