//
//  ODWelcomeNotificationViewController.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/6/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ODAppDelegate;

@interface ODWelcomeNotificationViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) ODAppDelegate * appDelegate;
@property (nonatomic, strong) IBOutlet UIImageView * welcomeNotBackgrounfImgView;
@property (nonatomic, strong) IBOutlet UITextView * welcomeNotText;
@property (nonatomic, strong) IBOutlet UILabel * welcomeNotificationNoteLabel;
@property (nonatomic, strong) IBOutlet UIButton * doneButton;
@property (nonatomic, strong) IBOutlet UIButton * previewButton;

@property (nonatomic, strong) IBOutlet UISwitch * activeSwitch;
@property (nonatomic, strong) IBOutlet UILabel * activeLabel;
@property (nonatomic, strong) IBOutlet UILabel * numberOfPeopleViewingWelcomeLabel;
@property (nonatomic, strong) IBOutlet UIImageView * numberOfViewersSeparatorImgView;
@property (nonatomic, strong) IBOutlet UILabel * counterLabel;

@property (nonatomic, strong) UIView * blockView;

@property (nonatomic) BOOL isViewInEditMode;

@end
